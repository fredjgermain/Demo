using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace BagStructure
{
    public class Iter<T> : IEnumerator<T>, IEnumerable<T>
    {
        // Props --------------------------------
        public Node<T> from, current;
        bool _forward;
        public Predicate<T> _predicate { get; set; }
        public Node<T> last => Last();

        public int i { get; set; }
        public bool forward => _forward;

        public T Current => current.value;     // null ref exception ?? at first iteration ??
        object IEnumerator.Current => Current;

        // Constructor --------------------------
        public Iter(Node<T> from, int offset)
        {
            Predicate<T> predicate = n =>
                Math.Abs(i) < Math.Abs(offset);
            Construct(from, offset >= 0, predicate);
        }
        public Iter(Node<T> from, bool forward = true)
            => Construct(from, forward, null);
        public Iter(Node<T> from, Predicate<T> predicate, bool forward = true)
            => Construct(from, forward, predicate);

        void Construct(Node<T> from, bool forward, Predicate<T> predicate)
        {
            Predicate<T> defaultPredicate = n => true;
            this.from = from;
            i = 0;
            _forward = forward;
            _predicate = predicate ?? defaultPredicate;
        }

        // Node is null -------------------------
        public static bool operator !(Iter<T> iter)
            => iter?.current == null;

        // Iterate ------------------------------
        public static Iter<T> operator ++(Iter<T> iter)
        {
            iter?.MoveNext();
            return iter;
        }

        Node<T> Last()
        {
            Iter<T> iter = this;
            Node<T> last = null;
            while (!!iter++)
                last = iter.current;
            return last;
        }

        public bool MoveNext()
        {
            if (!this)
            {
                Reset();
            }
            else
            {
                current = _forward ? current?.next : current?.prev;
                i += _forward ? +1 : -1;
            }
            if (!!this && !_predicate(Current))
                return MoveNext();
            return !!this;
        }

        public void Reset()
        {
            current = from;
            i = 0;
        }

        public void Dispose()
        {
            return;
        }

        // GetEnumerator ------------------------
        public IEnumerator<T> GetEnumerator() => this;
        IEnumerator IEnumerable.GetEnumerator() => this;
    }

}
