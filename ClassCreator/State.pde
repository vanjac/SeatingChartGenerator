List<Student> currentStudentList;

Student selectedStudent;

File selectedExcelFile;


void setupState() {
  println("Setup state...");
  selectedStudent = null;
  currentStudentList = new ArrayList<Student>();
  selectedExcelFile = null;
}


void updateStudents() {
  println("Updating students...");
  if(setupStudentList != 0)
    setupStudentList = 0;
  
  if(!currentStudentList.contains(selectedStudent)) {
    selectedStudent = null;
  }
}


void updateSelectedStudent() {
  println("Updating selected student...");
  
  lstStudents.setColor(ControlP5.THEME_CP5BLUE);
  
  if(selectedStudent != null) {
    int n = currentStudentList.indexOf(selectedStudent);
    //TODO
    //ListBoxItem item = lstStudents.getItem(n);
    //item.setColorBackground(listSelectedColor);
    
    txtFirstName.setValue(selectedStudent.getName(NameStyle.FIRST));
    txtMiddleName.setValue(selectedStudent.getName(NameStyle.MIDDLE));
    txtLastName.setValue(selectedStudent.getName(NameStyle.LAST));
    if(rdoGender.getValue() != selectedStudent.getGender().toInt())
      rdoGender.activate(selectedStudent.getGender().toInt());
  } else {
    txtFirstName.setValue("");
    txtMiddleName.setValue("");
    txtLastName.setValue("");
    rdoGender.deactivateAll();
  }
}


void updateSelectedExcelFile() {
  if(selectedExcelFile == null) {
    lblFile.setText("File: ");
    return;
  }
  
  lblFile.setText("File: " + selectedExcelFile.getName().toString());
}