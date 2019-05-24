using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

/*
 Iterator
 Infer a direction from received arguments. 
    - int from, int to
    - Node<T> a, Node<T> b, bool forward
            // ?? must detect if a is before or after b ??
    - Node<T> at, Predicate<Node<T>> predicate, bool forward

 Iter++ // move to the following element, either forward or backward. 
 Iter-- // rewind to the previously visited element. 
 !Iter  // hasFollowing element, either forward or backward. 
 Iter.from  // return first node beginning an iterator. 
 Iter.to    // return last node ending an iterator. 


 Iter<T> iter = new Iter<T>(nodeAt)
 while(!!iter++)
    iter.Current ... // return current node.

 

 */

namespace BagStructure
{
    public class Node<T> : IEnumerable<T>
    {
        // Props --------------------------------
        public T value;
        public Node<T> prev, next;
        public Node<T> first => new Iter<T>(this, false).last;
        public Node<T> last => new Iter<T>(this, true).last;

        // Constructor --------------------------
        public Node(T value = default(T)) 
            => Construct(value);

        void Construct(T value)
            => this.value = value;

        // Link, Add & Rem ----------------------
        public static Node<T> operator +(T a, Node<T> b)
            => Add(new Node<T>(a), b);
        public static Node<T> operator +(Node<T> a, T b)
            => Add(a, new Node<T>(b));
        public static Node<T> operator +(Node<T> a, Node<T> b)
            => Add(a, b);
        public static Node<T> operator -(Node<T> a)
            => Rem(a);

        // Node is null -------------------------
        public static bool operator !(Node<T> node)
            => node == null;

        // Indexer ------------------------------
        public Node<T> this[int offset]
        {
            get => Find(offset);
            set => Find(offset).value = value.value;
        }

        /*public static Node<T> operator <(Node<T> a, Node<T> b)
            => LinearSearch(a, n => n?.next==b, true);
        public static Node<T> operator >(Node<T> a, Node<T> b)
            => b < a;

        public static Node<T> operator <=(Node<T> a, Node<T> b)
            => LinearSearch(a, n => n == b, true);
        public static Node<T> operator >=(Node<T> a, Node<T> b)
            => b <= a;
        */

        // Count ................................
        public int Count(bool forward = true)
            => Count(new Iter<T>(this, forward));
        public int Count(T t, bool forward = true)
            => Count(c => c.Equals(t), forward);
        public int Count(Predicate<T> predicate, bool forward = true)
            => Count(new Iter<T>(this, predicate, forward));
        
        // Pick .................................
        public Node<T> Pick(int offset)
            => Pick(new Iter<T>(this, offset));
        public Node<T> Pick(bool forward = true)
            => Pick(new Iter<T>(this, forward));
        public Node<T> Pick(T t, bool forward = true)
            => Pick(c => c.Equals(t), forward);
        public Node<T> Pick(Predicate<T> predicate, bool forward = true)
            => Pick(new Iter<T>(this, predicate, forward));
        
        // Find .................................
        public Node<T> Find(int offset)
            => Find(new Iter<T>(this, offset));
        public Node<T> Find(bool forward = true)
            => Find(new Iter<T>(this, forward));
        public Node<T> Find(T t, bool forward = true)
            => Find(c => c.Equals(t), forward);
        public Node<T> Find(Predicate<T> predicate, bool forward = true)
            => Find(new Iter<T>(this, predicate, forward));

        // ForEach ..............................
        public void ForEach(Action<T> toDoForEach)
            => ForEach(new Iter<T>(this), toDoForEach);
        
        // Iterate ------------------------------
        public static Node<T> operator ++(Node<T> node) 
            => node?.next;
        public static Node<T> operator --(Node<T> node)
            => node?.prev;

        // Algo =================================
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

        // Count algo - O(n)
        int Count(Iter<T> iter)
        {
            int i = 0;
            ForEach(iter, n => i++);
            return i;
        }

        // Pick algo - O(n) 
        Node<T> Pick(Iter<T> iter)
        {
            Node<T> picks = null;
            ForEach(iter, t => picks += t);
            return picks;
        }

        // Search algo - O(n)
        Node<T> Find(Iter<T> iter)
        {
            Node<T> last = null;
            while (!!iter++)
                last = iter.current;
            return last;
        }

        // ForEach - O(n)
        void ForEach(Iter<T> iter, Action<T> toDoForEach)
        {
            foreach (T t in iter)
                toDoForEach(t);
        }

        // ToString -----------------------------
        public override string ToString()
            => $"{value}";
        
        // GetEnumerator ------------------------
        public IEnumerator<T> GetEnumerator() 
            => new Iter<T>(this, true);
        IEnumerator IEnumerable.GetEnumerator()
            => new Iter<T>(this, true);
    }
}
