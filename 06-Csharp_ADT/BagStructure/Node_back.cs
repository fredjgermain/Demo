using System;
using System.Collections.Generic;
using System.Text;

namespace BagStructure
{
    public class Node<T> : IEnumerable<T>
    {
        // Props --------------------------------
        public T value;
        public Node<T> prev, next;
        public Node<T> first => First();
        public Node<T> last => Last();

        // Constructor --------------------------
        public Node(T value = default(T)) => Construct(value);

        void Construct(T value)
            => this.value = value;

        public Node<T> Copy()
            => new Node<T>(value);

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
            get => Offset(this, offset);
            set => Offset(this, offset).value = value.value;
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

        // Count, Pick ---------------------------
        public int Count()
        {
            int i = 0;
            foreach (T t in Iter()) i++;
            return i;
        }

        /*public int Count()
        {
            int i = 0;
            foreach (T t in Iter()) i++;
            return i;
        }*/

        public Node<T> Pick(bool forward)
        {
            Node<T> picks = null;
            foreach (T t in Iter(forward))
                picks += t;
            return picks;
        }

        public Node<T> Pick(int offset)
        {
            Node<T> picks = null;
            foreach (T t in Iter(offset))
                picks += t;
            return picks;
        }

        public Node<T> Pick(Predicate<T> predicate, bool forward = true)
        {
            Node<T> picks = null;
            Iter<T> iter = Iter(predicate);
            foreach (T t in iter)
                picks += t;
            return picks;
        }

        /*public Node<T> Pick(Predicate<Node<T>> predicate, bool forward = true)
        {
            Node<T> node = this;
            Node<T> picks = null;
            while (!!node)
            {
                if (predicate(node))
                    picks += node.Copy();
                node = forward ? node.next : node.prev;
            }
            return picks;
        }*/

        /*public Node<T> FindNext(T toFind)
        {

        }
        public Node<T> FindNext(Predicate<Node<T>> predicate)
            => LinearSearch(this, predicate);
        public Node<T> FindPrev(Predicate<Node<T>> predicate)
            => LinearSearch(this, predicate, false);
            */


        // Iterate ------------------------------
        public static Node<T> operator ++(Node<T> node)
            => node?.next;
        public static Node<T> operator --(Node<T> node)
            => node?.prev;


        // Algo =================================
        /* Add, Rem, Link algo ------------------
            O(1) */
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

        /* Search algo ------------------
            O(n) */
        Node<T> First()
            => LinearSearch(this, n => !n.prev, false);
        Node<T> Last()
            => LinearSearch(this, n => !n.next, true);

        static Node<T> Offset(Node<T> node, int offset)
        {
            if (!node || offset == 0)
                return node;
            node = offset > 0 ? node.next : node.prev;
            offset += offset > 0 ? -1 : +1;
            return Offset(node, offset);
        }

        /*static Node<T> Offset(Node<T> node, int offset)
        {
            Predicate<Node<T>> predicate = n =>
            {
                if (offset == 0)
                    return true;
                offset += offset > 0 ? -1 : +1;
                return false;
            };
            return LinearSearch(node, predicate, offset > 0);
        }*/

        static Node<T> LinearSearch(Node<T> node, Predicate<Node<T>> predicate, bool forward = true)
        {
            //Console.WriteLine($"{node}");
            if (!node || predicate(node))
                return node;
            node = forward ? node.next : node.prev;
            return LinearSearch(node, predicate, forward);
        }


        // ToString -----------------------------
        public override string ToString()
            => $"{value}";

        public Iter<T> Iter(bool forward = true)
            => new Iter<T>(this, forward);

        public Iter<T> Iter(Predicate<T> predicate, bool forward = true)
        {
            return new Iter<T>(this, predicate, forward);
        }

        public Iter<T> Iter(int bound)
            => new Iter<T>(this, bound);

        public IEnumerator<T> GetEnumerator()
        {
            Console.WriteLine("Get Enumerator <T>");
            return Iter();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            Console.WriteLine("Get Enumerator");
            return Iter();
        }


        // GET ENUMERATOR ...
        // GET ENUM [forward] ??
        // GET ENUM [offset] ??
        // 
    }
}
