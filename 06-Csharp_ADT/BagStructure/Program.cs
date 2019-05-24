using System;

namespace BagStructure
{
    public class Program
    {
        public static void Write<T>(Node<T> node)
        {
            if (!node)
            {
                Console.WriteLine("null");
                return;
            }
            foreach (T t in node)
                Console.Write($"{t}, ");
            Console.WriteLine("\n");
        }


        public static void Main(string[] args)
        {
            Console.WriteLine("--- Start ---");

            Node<int> a = new Node<int>(10);
            Node<int> b = a + 11 + 12 + 13 + 14 + 15;

            Write(a);

            int offset = 3;
            Node<int> c = a[offset];

            Predicate<int> even = t => t % 2 == 0;
            Console.WriteLine(a.Count(12));
            Write(a);
            Write(b);
            Write(c);

            Console.WriteLine($"{c.first} : {c.last}");

            Node<int> d = b.first;
            Node<int> e = a.last;
            
            Console.WriteLine($"b = {b}");
            Write(b);
            Console.WriteLine($"c = {c}");
            Write(c);
            Console.WriteLine($"d = {d}");
            Write(d);
            Console.WriteLine($"e = {e}");
            Write(e);

            Console.WriteLine($"a[{offset}] = {c}");
            Write(c);
            Console.WriteLine($"first = {d}");
            Write(d);
            Console.WriteLine($"last = {e}");
            Write(e);

            

            Console.WriteLine($" picks ---- ");
            Node<int> f = a.Pick(even).first;
            Write(f);
            Console.WriteLine($"Count {a.Count(even)}");
            //Node<int> f = a.Pick(even);
            //Console.WriteLine($"pick = {f.first} {f.last}");

            /*f = a.Pick(2);
            Console.WriteLine($"pick = {f.first} {f.last}");*/


            /*int offset = 4;
            Predicate<Node<int>> predicate = node => offset-- == 0;
            Console.WriteLine(Node<int>.LinearSearch(a, predicate));*/

            Console.WriteLine("--- End ---");
            Console.ReadKey();
        }
    }
}
