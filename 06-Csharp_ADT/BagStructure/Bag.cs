using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace BagStructure
{
    // BAG ######################################
    public interface IBag<T> : IEnumerable<T>
    {
        //int Card { get; set; }

        void Add(T toAdd);
        void Add(IBag<T> toAdd);

        void Rem(T toRem);
        void Rem(IBag<T> toRem);

        bool Count();
        bool Count(T toCount);
        bool Count(Predicate<T> toCount);

        bool Find(T t);
        bool Find(Predicate<T> toFind);

        //bool Pick(int toPick);  // +n := first n elems, -n last n elems.
        bool Pick(Predicate<T> toPick);

        void ForEach(Action<T> toDoForEach);

    }

    public class Bag<T>
    {
        // Props --------------------------------
        public T value;
        public Node<T> first, last;

        // Constructor --------------------------
        public Bag()
        {

        }

        void Construct(Node<T> node)
        {

        }

        // Add, Rem
        Bag<T> Add(Bag<T> toAdd)
        {
            first = !first? toAdd?.first: first;
            last = toAdd?.last;
            return null;
        }
        Bag<T> Rem(Bag<T> toRem)
        { return null; }
        
    }


    // ITER #####################################    
    public class Iter<T> : IEnumerator<T>
    {
        // Props --------------------------------
        Node<T> _it;
        public Node<T> at { get; set; }
        public int index { get; set; }
        public bool forward { get; set; }
        public Predicate<T> predicate { get; set; }

        public T Current => at.value;
        object IEnumerator.Current => Current;

        // Constructor --------------------------
        public Iter(Node<T> at, bool forward = true)
            => Construct(at, null);
        public Iter(Node<T> at, int offset)
            => Construct(at, (t => Math.Abs(index) < Math.Abs(offset)), offset >= 0);
        public Iter(Node<T> at, Predicate<T> predicate, bool forward = true)
            => Construct(at, predicate);

        void Construct(Node<T> at, Predicate<T> predicate, bool forward = true)
        {
            this.at = _it = at;
            index = 0;
            this.predicate = predicate ?? (t => true);
            this.forward = forward;
        }

        // Is Null ?
        public static bool operator !(Iter<T> iter)
            => iter?.at == null;        

        // Move To ------------------------------
        public static Iter<T> operator ++(Iter<T> iter)
        {
            if (!iter)
                return null;
            iter.MoveNext();
            return iter;
        }

        public bool MoveNext()
        {
            if (!this)
            {
                Reset();
            }
            else
            {
                at = forward ? at++ : at--;
                index += forward ? +1 : -1;
            }
            if (!!this && !predicate(Current))
                return MoveNext();
            return !!this;
        }

        // Reset --------------------------------
        public void Reset()
        {
            at = _it;
            index = 0;
        }

        public Iter<T> Last()
        {
            Iter<T> iter = this, last = null;
            while (!!iter++)
                last = iter;
            return last;
        }

        // Dispose
        public void Dispose()
        {
            return;
        }

    }

    // NODE #####################################
    public class Node<T>
    {
        // Props --------------------------------
        public T value;
        public Node<T> prev, next;

        // Constructor --------------------------
        public Node(T value = default(T))
            => Construct(value);

        void Construct(T value)
            => this.value = value;

        // Node is null -------------------------
        public static bool operator !(Node<T> node)
            => node == null;

        // Link, Add & Rem ----------------------
        public static Node<T> operator +(T a, Node<T> b)
            => Add(new Node<T>(a), b);
        public static Node<T> operator +(Node<T> a, T b)
            => Add(a, new Node<T>(b));
        public static Node<T> operator +(Node<T> a, Node<T> b)
            => Add(a, b);
        public static Node<T> operator -(Node<T> a)
            => Rem(a);

        // Iterate ..............................
        public static Node<T> operator ++(Node<T> node)
            => node?.next;
        public static Node<T> operator --(Node<T> node)
            => node?.prev;

        // Add, Rem, Link algo - O(1)
        static Node<T> Rem(Node<T> a)
        {
            Node<T> prev = a?.prev;
            Link(null, a);
            return prev;
        }
        static Node<T> Add(Node<T> a, Node<T> b)
        {
            Link(a, b);
            return b ?? a;
        }
        static void Link(Node<T> a, Node<T> b)
        {
            if (!!a?.next)
                a.next.prev = null;
            if (!!b?.prev)
                b.prev.next = null;
            if (!!a)
                a.next = b;
            if (!!b)
                b.prev = a;
        }

    }

}
