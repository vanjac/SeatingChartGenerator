interface ExcelFileReader {
  public List<Student> read(PApplet applet, String file, int startColumn, int startRow, int readDirection);
}

/*Read directions:
  0: Right
  1: Down
*/

class GenericExcelFileReader implements ExcelFileReader {
  public List<Student> read(PApplet applet, String file, int startColumn, int startRow, int readDirection) {
    List<Student> studentList = new ArrayList<Student>();
    
    HSSFSheet sheet;
    try {
      POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(file));
      HSSFWorkbook wb = new HSSFWorkbook(fs);
      sheet = wb.getSheetAt(0);
    } catch (IOException ex) {
      println(ex);
      return studentList;
    }
    
    println("Reader created");
    
    int row = startRow;
    int column = startColumn;
    String name;
    
    while(true) {
      try {
        println("Reading cell...");
        HSSFRow r = sheet.getRow(row-1);
        if(r != null) {
          HSSFCell c = r.getCell(column - 1);
          name = c.getStringCellValue();
        } else {
          name = "";
        }
      } catch (NullPointerException e) {
        break;
      }
      if(name == null)
        break;
      if(name.isEmpty())
        break;
      
      println(name);
      studentList.add(new Student(name, "", "", new GenderNone()));
      
      switch(readDirection) {
        case 0:
          column++;
          break;
        case 1:
          row++;
          break;
        
      }
    }
    
    return studentList;
  }
}