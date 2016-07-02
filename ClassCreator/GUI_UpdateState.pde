int setupStudentList = -1;
final int setupStudentListCount = 1;
int setupExcelDialog = -1;
final int setupExcelDialogCount = 2;
int setupExcelDialogGUI = -1;
final int setupExcelDialogGUICount = 4;


void checkStateUpdates() {
  noLoop();
  
  Thread t = new Thread(new Runnable() {
    public void run() {
      try {
        Thread.sleep(100);
      } catch(Exception e) {
        println("Exception when sleeping: " + e.toString());
      }
      if(setupStudentList >= 0) {
        if(++setupStudentList == setupStudentListCount) {
          setupStudentList();
          setupStudentList = -1;
        }
      }
      
      if(setupExcelDialogGUI >= 0) {
        if(++setupExcelDialogGUI == setupExcelDialogGUICount) {
          setupExcelDialogGUI();
          setupExcelDialogGUI = -1;
        }
      }
      
      if(setupExcelDialog >= 0) {
        if(++setupExcelDialog == setupExcelDialogCount) {
          setupExcelDialog();
        }
      }
      
      loop();
    }
    
  });
  
  t.start();
  //t.yield();
}

void createExcelDialog() {
  frmExcelDialog = addControlFrame("Load from Excel file", 256, 224);
  setupExcelDialog = 0;
}


void setupStudentList() {
  
  println("Setup student list...");
  
  lstStudents.clear();
  int i = 0;
  for(Student s : currentStudentList) {
    lstStudents.addItem(s.getName(NameStyle.FULL) + "   (" + s.getGender().toChar() + ")", i++);
  }
  
  lstStudents.setLabel("Students (" + currentStudentList.size() + ")");
  
  updateSelectedStudent();
}


void setupExcelDialog() {
  println("Setup Excel dialog...");
  
  
  frmExcelDialog.setupGUI();
  
  final ControlFrame frame = frmExcelDialog;
  
  frame.setBackground(191);
  ControlP5 cp5 = frame.cp5();
  
  setupExcelDialogGUI = 0;
  frmExcelDialog.noLoop();
}


void setupExcelDialogGUI() {
  
  
  final ControlFrame frame = frmExcelDialog;
  ControlP5 cp5 = frame.cp5();
  
  if(selectedExcelFile == null) {
    cp5.addTextlabel("ExcelFileError")
      .setText("Error reading file.\nPlease choose a valid '.xls' file.\n'.xlsx' files will not work.")
      .setPosition(4, 4)
      .setColor(errorColor)
      ;
    
    frame.loop();
    return;
  }
  
  lblFile = cp5.addTextlabel("File")
    .setText("File: ")
    .setPosition(4, 4)
    .setColor(labelColor);
    ;
  
  if(selectedExcelFile != null)
    lblFile.setText("File: " + selectedExcelFile.getName().toString());
  
  cp5.addTextlabel("Cell")
    .setText("Cell to start at:")
    .setPosition(4, 24)
    .setColor(labelColor);
    ;
  
  txtCellColumn = cp5.addTextfield("Column (A-Z)")
    .setPosition(4, 36)
    .setWidth(48)
    .setColorCaptionLabel(labelColor)
    .setValue("A")
    .setAutoClear(false)
    ;
  
  txtCellRow = cp5.addTextfield("Row #")
    .setPosition(64, 36)
    .setWidth(48)
    .setColorCaptionLabel(labelColor)
    .setValue("1")
    .setAutoClear(false)
    ;
  
  cp5.addTextlabel("Read")
    .setText("Read direction:")
    .setPosition(4, 84)
    .setColor(labelColor);
    ;
  
  rdoReadDir = cp5.addRadioButton("ReadDirection")
    .setPosition(4, 96)
    .setColorLabel(labelColor)
    .addItem("Move right", 0)
    .addItem("Move down", 1)
    .activate(1)
    ;
  
  cp5.addTextlabel("ReadInfo")
    .setText("Cells will be read until an empty cell is encountered")
    .setPosition(4, 120)
    .setColor(labelColor)
    ;
  
  lblError = cp5.addTextlabel("ExcelError")
    .setText("")
    .setPosition(4, 136)
    .setWidth(frame.width - 80)
    .setColor(errorColor)
    ;
  
  
  Button btnOK = cp5.addButton("OK")
    .setPosition(frame.width - 80, 136)
    .setSize(64, 24)
    ;
  frame.addEvent(btnOK, new CP5EventAction() {
    public void run(ControlEvent e) {
      if(selectedExcelFile == null) {
        lblError.setText("Please choose a file.").setColor(errorColor);
        return;
      }
      if(txtCellColumn.getText().isEmpty() || txtCellRow.getText().isEmpty()) {
        lblError.setText("Please enter a single column letter\nand a valid row number.").setColor(errorColor);
        return;
      }
      
      ExcelFileReader reader = new GenericExcelFileReader();
      try {
        currentStudentList.addAll(reader.read(applet(), selectedExcelFile.toString(),
          txtCellColumn.getText().toLowerCase().charAt(0) - 'a' + 1, Integer.parseInt(txtCellRow.getText()), (int)rdoReadDir.getValue()));
        lblError.setText("File read").setColor(successColor);
        updateStudents();
      } catch (NumberFormatException ex) {
        lblError.setText("Please enter a single column letter\nand a valid row number.").setColor(errorColor);
        return;
      }
    }
  });
  
  frame.loop();
}