void classFileLoaded(File f) {
  if(f == null)
    return;
  
  if(!getFileExtension(f.toString()).equals("scclass")) {
    println("Incorrect extension");
    return;
  }
  
  List<Student> result = new GenericClassFileReader().read(f.toString());
  
  if(result == null)
    return;
  
  currentStudentList = result;
  updateStudents();
}


void classFileSaved(File f) {
  if(f == null)
    return;
  
  String fileName = f.toString();
  if(!fileName.endsWith(".scclass"))
    fileName = fileName + ".scclass";
  
  boolean result = new GenericClassFileWriter().write(fileName, currentStudentList);
}


void excelFileLoaded(File f) {
  if(f == null)
    return;
    
    selectedExcelFile = f;
  
  if(!getFileExtension(f.toString()).equals("xls")) {
    println("Incorrect extension");
    selectedExcelFile = null;
  }
  
  
  createExcelDialog();
}
