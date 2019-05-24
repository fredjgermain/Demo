using System;
using System.Collections.Generic;
using System.Text;

namespace BagStructure
{
    public class Iter<T> : IEnumerator<T>, IEnumerable<T>
    {
        // Props --------------------------------
        Node<T> _from, _current;
        bool _forward;
        int _i;
        int? _bound;
        public Predicate<T> _predicate { get; set; }

        public Node<T> from => _from;
        public int index => _i;
        public bool forward => _forward;

        public T Current => _current.value;     // null ref exception ?? at first iteration ??
        object IEnumerator.Current => Current;

        // Constructor --------------------------
        public Iter(Node<T> from, Predicate<T> predicate, bool forward = true)
            => Construct(from, null, true, predicate);
        public Iter(Node<T> from, bool forward = true)
            => Construct(from, null, forward, null);
        public Iter(Node<T> from, int bound)
            => Construct(from, bound, bound >= 0, null);
        public Iter(Iter<T> iter)
            => Construct(iter._from, iter._bound, iter._forward, iter._predicate);

        void Construct(Node<T> from, int? bound, bool forward, Predicate<T> predicate)
        {
            _current = null;    // will reset at next
            _from = from;
            _forward = forward;
            _bound = bound;
            _predicate = predicate;
            if (_predicate == null)
                _predicate = t => true;
        }

        bool IsInBound() => IsInBound(_i);
        bool IsInBound(int i)
        {
            i = Math.Abs(i);
            if (_bound == null)
                return 0 <= i;
            int bound = Math.Abs((int)_bound);
            return (0 <= i && i <= bound);
        }

        public static bool operator !(Iter<T> iter)
            => !(iter._current) || !(iter.IsInBound());

        public static Iter<T> operator ++(Iter<T> iter)
        {
            iter?.MoveNext();
            return iter;
        }

        public bool MoveNext()
        {
            if (!this)
            {
                Reset();
                return !!_current && IsInBound();
            }
            _current = _forward ? _current?.next : _current?.prev;
            _i = _forward ? _i + 1 : _i - 1;

            if (!!this && _predicate != null && _predicate(_current.value))
                Console.WriteLine($" move next {_current.value}");
            /*if (!!this)
                Console.WriteLine($" move next {_current.value} {_predicate(_current.value)}");*/
            return !!this;
        }

        public void Reset()
        {
            //Console.WriteLine("Reset");
            _current = _from;
            _i = 0;
        }

        public void Dispose()
        {
            return;
        }

        public IEnumerator<T> GetEnumerator()
        {
            Console.WriteLine("Get Enumerator <T>");
            return new Iter<T>(this);
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            Console.WriteLine("Get Enumerator");
            return new Iter<T>(this);
        }
    }
}
