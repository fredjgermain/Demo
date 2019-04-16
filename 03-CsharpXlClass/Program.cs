using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using OfficeOpenXml;

namespace XlUtil
{
    using Package = ExcelPackage;
    using Sheet = ExcelWorksheet;
    using Book = ExcelWorkbook;
    using Address = ExcelCellAddress;
    using Cells = IEnumerable<Cell>;

    public class Program
    {
        public static void Write<T>(T o)
            => Console.Write($"{o} ");

        public static void Write<T>(IEnumerable<T> items)
        {
            Console.WriteLine("As ienum");
            foreach (T t in items)
                Write(t);
            Console.WriteLine("\nend ienum");
        }

        public static void Main(string[] args)
        {
            Console.WriteLine("----------");

            string xlFile = @"D:\01-Projects\01-ProjectMedia\01-Tourjman\01-Project\01-Prototype_v01\Prototype_v01\XlForm.xlsx";
            Xl xl = new Xl(xlFile);
            //Console.WriteLine(xl.activeSheet.Name);

            // Dictionary<string, Label> 
            Dictionary<string, string> langs = new Dictionary<string, string>();
            xl.FindSheet("LangSheet");

            //IEnumerable<Cell> cells = xl.Cells(c => (string)c.value == "Lang");
            //Write(cells);
            IEnumerable<Cell> cells;
            int[] rows = new int[] { 2, 3 };
            int[] cols = new int[] { 1 };
            cells = xl.Cells(rows, null);
            Write(cells.Select(c=>c.value));

            Xl to Dictionnary(Lang)

            

            /*xl.Save("Test.xlsx");

            Xl xl = new Xl();
            xl.Open("Null.xlsx");

            foreach (var s in xl.sheets)
                Console.WriteLine(s.Name);
            xl.activeSheet = xl.sheets.LastOrDefault();

            xl["D1"] = "par address";
            xl[1, 1] = "a";
            xl[1, 2] = "aa";
            xl[2, 1] = "b";
            xl[3, 1] = "bb";

            foreach (var c in xl.activeSheet.Cells)
                Console.WriteLine(c.Address + " / " + c.Value);
                */

            Console.WriteLine("----------");
            Console.ReadKey();
        }
    }
}
