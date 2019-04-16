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

    public class Cell
    {
        // PROPS --------------------------------
        ExcelRangeBase _cell;

        // CONSTRUCTOR --------------------------------
        public Cell(ExcelRangeBase cell)
            => _cell = cell;

        // OPEN, SAVE ---------------------------
        public Address address 
            => new Address(_cell.Address);
        public int row => address.Row;
        public int col => address.Column;
        public object value {
            get => _cell.Value;
            set => _cell.Value = value;
        }

        // CELL
        public static implicit operator Cell(ExcelRangeBase cell)
            => new Cell(cell);

        // TO_STRING ----------------------------
        public override string ToString()
            => $"{_cell.Address} ({row}, {col}) : {_cell.Value}";

    }

    public class Xl
    {
        // PROPS --------------------------------
        public Package package;
        public Book book => package.Workbook;
        public IEnumerable<Sheet> sheets => book.Worksheets;

        public Sheet activeSheet { get; set; }
        public Sheet defaultSheet
            => sheets.FirstOrDefault() ?? AddSheet("Sheet1");

        public Address start => activeSheet.Dimension.Start;
        public Address end => activeSheet.Dimension.End;

        public int rows => activeSheet.Dimension.Rows;
        public int cols => activeSheet.Dimension.Columns;

        // CONSTRUCTOR --------------------------
        public Xl()
            => Construct(null);
        public Xl(string xlFileName)
            => Construct(xlFileName);

        void Construct(string xlFileName)
        {
            package = new Package();
            Open(xlFileName);
        }

        // OPEN, SAVE ---------------------------
        public bool Open(string xlFileName)
        {
            if (File(xlFileName) == null)
                return false;
            return TryXl(open);
        }
        public bool Save()
            => Save(_file.Name);
        public bool Save(string xlFileName)
        {
            if (File(xlFileName) == null)
                return false;
            return TryXl(save);
        }

        Action<Xl> open = xl => {
            xl.package.Load(xl._file);
            xl.activeSheet = xl.defaultSheet;
        };
        Action<Xl> save = xl => xl.package.SaveAs(xl._file);
        bool TryXl(Action<Xl> action)
        {
            try
            {
                action(this);
            }
            catch (Exception)
            {
                _file.Close();
                return false;
            }
            _file.Close();
            return true;
        }

        // file getter & setter
        FileStream _file;
        FileStream File(string xlFileName)
        {
            _file = null;
            if (!string.IsNullOrEmpty(xlFileName))
                _file = new FileStream(xlFileName, FileMode.OpenOrCreate);
            return _file;
        }

        // SHEET --------------------------------
        public Sheet FindSheet(string sheetName)
            => sheets.SingleOrDefault( s => s.Name == sheetName);
        public Sheet AddSheet(string sheetName)
        {
            if (FindSheet(sheetName) is null)
                return book.Worksheets.Add(sheetName);
            return null;
        }
        public bool RemSheet(string sheetName)
        {
            if (FindSheet(sheetName) is null)
                return false;
            book.Worksheets.Delete(sheetName);
            return true;
        }

        // IS_EMPTY 
        public bool IsEmpty(Book wBook)
            => wBook is null || wBook.Worksheets.Count() == 0;
        public bool IsEmpty(Sheet sheet)
        {            
            if (sheet is null || 
                (sheet.Dimension.Rows == 0 && sheet.Dimension.Columns == 0))
                return true;
            return false;
        }

        // CELLS --------------------------------
        public object this[int row, int col]
        {
            get => Cell(row, col).value;
            set => Cell(row, col).value = value;
        }
        public object this[string address]
        {
            get => Cell(address).value;
            set => Cell(address).value = value;
        }
        public object this[Predicate<Cell> predicate]
        {
            get => Cell(predicate).value;
            set => Cell(predicate).value = value;
        }

        public Cells Cells()
            => activeSheet?.Cells.Select(c => (Cell)c);
        public Cells Cells(Predicate<Cell> predicate)
            => Cells().Where(c => predicate(c));
        public Cells Cells(int[] row, int[] col)
        {
            Func<int[], int, bool> test = delegate(int[] array, int i) {
                if (array is null || array.Contains(i))
                    return true;
                return false;
            };
            return Cells().Where(c => test(row, c.row) && test(col, c.col));
        }

        public Cell Cell(Predicate<Cell> predicate)
            => activeSheet?.Cells.Where(c => predicate(c)).FirstOrDefault();
        public Cell Cell(int row, int col)
            => activeSheet?.Cells[row, col];
        public Cell Cell(string address)
            => activeSheet?.Cells[address];

        // INDEXER ------------------------------
        /*public object this[string address]
        {
            get => Cell(address).Value;
            set => Cell(address).Value = value;
        }
        public object this[int row, int col]
        {
            get => Cell(row, col).Value;
            set => Cell(row, col).Value = value;
        }
        */
        // ROW, COLS & CELLS --------------------
        /*public IEnumerable<Cell> Cells(Predicate<Cell> predicate)    
            => activeSheet?.Cells.Where(c => predicate(c));

        public IEnumerable<Cells> Rows()
            => Rows(c => true);
        public IEnumerable<Cells> Cols()
            => Cols(c => true);

        public IEnumerable<Cells> Rows(Predicate<Cell> predicate)
        {
            IEnumerable<Cell> row;
            for(int r = start.Row; r <= end.Row; r++)
            {
                row = Row(r).Where(cell => predicate(cell));
                if (row != null || row.Count() > 0)
                    yield return Row(r);
            }
        }
        public IEnumerable<Cells> Cols(Predicate<Cell> predicate)
        {
            IEnumerable<Cell> col;
            for (int c = start.Column; c <= end.Column; c++)
            {
                col = Col(c).Where(cell => predicate(cell));
                if (col != null || col.Count() > 0)
                    yield return Col(c);
            }
        }

        public Cells Row(int row)
            => Cells(row, start.Column, row, end.Column);
        public Cells Col(int col)
            => Cells(start.Row, col, end.Row, col);

        // CELLS --------------------------------
        public Cells Cells(int fromRow, int fromCol, int toRow, int toCol)
            => activeSheet?.Cells[fromRow, fromCol, toRow, toCol];
        public Cells Cells(Address a, Address b)
            => Cells(a.Row, a.Column, b.Row, b.Column);
        public Cell Cell(int row, int col)
            => activeSheet?.Cells[row, col];
        public Cell Cell(string address)
            => activeSheet?.Cells[new Address(address).Address];
        public Cell Cell(Address address)
            => activeSheet?.Cells[address.Address];
            */
        // TO_STRING ----------------------------
        /*public override string ToString()
        {
            string str = _file?.Name ?? "new.xlsx\n";
            foreach (Sheet s in sheets)
                str += (s == sheets.First()) ? s.Name: ", " + s.Name;
            str += SheetToString();
            return str;
        }*/

        /*public string SheetToString()
        {
            string str = "";
            foreach (Cell c in activeSheet?.Cells)
            {
                str += c.Value.ToString();
                if (c.Columns >= c.End.Column)
                    str += "\n";
                else if (c != activeSheet.Cells.Last())
                    str += ", ";
            }
            return str;
        }*/

    }
}
