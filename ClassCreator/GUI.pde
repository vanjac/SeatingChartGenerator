ControlP5 cp5;

final color groupBackgroundColor = color(127);
final color listSelectedColor = color(63, 191, 63);
final color labelColor = color(0);
final color errorColor = color(191, 0, 0);
final color successColor = color(0, 127, 0);

final String errorText = "$ERROR";


Button btnLoad;
Button btnLoadExcel;
Button btnClear;
Button btnSave;

ListBox lstStudents;

Button btnNew;
Button btnRemove;

Textfield txtFirstName;
Textfield txtMiddleName;
Textfield txtLastName;
RadioButton rdoGender;

ControlFrame frmExcelDialog;
Button btnCancel;
Button btnOK;
Textlabel lblFile;
Button btnChooseFile;
Textfield txtCellColumn;
Textfield txtCellRow;
RadioButton rdoReadDir;
Textlabel lblError;


void setupGUI() {
  println("Setup GUI...");
  cp5 = new ControlP5(this);
  
  setupEvents();
  
  cp5.addTextlabel("Info")
    .setText("Jacob van't Hoog, 2015")
    .setPosition(0, height - 16)
    .setWidth(width)
    .setColor(labelColor)
    ;
  
  
  lstStudents = cp5.addListBox("StudentList")
    .setLabel("Students")
    .setPosition(0, 48)
    .setSize(192, height - 64)
    ;
  addEvent(lstStudents, new CP5EventAction() {
    public void run(ControlEvent e) {
      int n = (int)e.getValue();
      if(currentStudentList == null)
        return;
      selectedStudent = currentStudentList.get(n);
      updateSelectedStudent();
    }
  });
  
  
  btnNew = cp5.addButton("+ Student")
    .setPosition(224, 32)
    .setSize(63, 24)
    ;
  addEvent(btnNew, new CP5EventAction() {
    public void run(ControlEvent e) {
      if(currentStudentList == null)
        return;
      Student s = new Student();
      currentStudentList.add(s);
      selectedStudent = s;
      updateStudents();
    }
  });
  
  btnRemove = cp5.addButton("- Student")
    .setPosition(288, 32)
    .setSize(63, 24)
    ;
  addEvent(btnRemove, new CP5EventAction() {
    public void run(ControlEvent e) {
      if(selectedStudent == null || currentStudentList == null)
        return;
      currentStudentList.remove(selectedStudent);
      selectedStudent = null;
      updateStudents();
    }
  });
  
  
  setupFilePanel();
  setupInfoPanel();
}


void setupFilePanel() {
  btnLoad = cp5.addButton("Load")
    .setPosition(0, 0)
    .setSize(63, 24)
    ;
  addEvent(btnLoad, new CP5EventAction() {
    public void run(ControlEvent e) {
      selectInput("Select a class file to load:", "classFileLoaded");
    }
  });
  
  btnLoadExcel = cp5.addButton("Load Excel")
    .setPosition(64, 0)
    .setSize(63, 24)
    ;
  addEvent(btnLoadExcel, new CP5EventAction() {
    public void run(ControlEvent e) {
      selectInput("Select an Excel file to read:", "excelFileLoaded");;
    }
  });
  
  
  btnClear = cp5.addButton("Clear")
    .setPosition(128, 0)
    .setSize(63, 24)
    ;
  addEvent(btnClear, new CP5EventAction() {
    public void run(ControlEvent e) {
      currentStudentList.clear();
      updateStudents();
    }
  });
  
  
  btnSave = cp5.addButton("Save")
    .setPosition(192, 0)
    .setSize(63, 24)
    ;
  addEvent(btnSave, new CP5EventAction() {
    public void run(ControlEvent e) {
      selectOutput("Select the file to save to:", "classFileSaved");
    }
  });
}


void setupInfoPanel() {
  txtFirstName = cp5.addTextfield("First Name")
    .setPosition(224, 64)
    .setWidth(152)
    .setColorCaptionLabel(labelColor)
    .setAutoClear(false)
    ;
  addEvent(txtFirstName, new CP5EventAction() {
    public void run(ControlEvent e) {
      if(selectedStudent == null)
        return;
      
      selectedStudent.setFirstName(txtFirstName.getStringValue());
      updateStudents();
    }
  });
  
  txtMiddleName = cp5.addTextfield("Middle Name")
    .setPosition(224, 100)
    .setWidth(152)
    .setColorCaptionLabel(labelColor)
    .setAutoClear(false)
    ;
  addEvent(txtMiddleName, new CP5EventAction() {
    public void run(ControlEvent e) {
      if(selectedStudent == null)
        return;
      
      selectedStudent.setMiddleName(txtMiddleName.getStringValue());
      updateStudents();
    }
  });
  
  txtLastName = cp5.addTextfield("Last Name")
    .setPosition(224, 136)
    .setWidth(152)
    .setColorCaptionLabel(labelColor)
    .setAutoClear(false)
    ;
  addEvent(txtLastName, new CP5EventAction() {
    public void run(ControlEvent e) {
      if(selectedStudent == null)
        return;
      
      selectedStudent.setLastName(txtLastName.getStringValue());
      updateStudents();
    }
  });
  
  rdoGender = cp5.addRadioButton("Gender")
    .setPosition(224, 188)
    .setColorLabel(labelColor)
    .addItem("None", 0)
    .addItem("Male", 1)
    .addItem("Female", 2)
    ;
  addEvent(rdoGender, new CP5EventAction() {
    public void run(ControlEvent e) {
      if(selectedStudent == null)
        return;
      
      if(rdoGender.getState(0))
        selectedStudent.setGender(new GenderNone());
      if(rdoGender.getState(1))
        selectedStudent.setGender(new GenderMale());
      if(rdoGender.getState(2))
        selectedStudent.setGender(new GenderFemale());
      
      
      updateStudents();
    }
  });
}



