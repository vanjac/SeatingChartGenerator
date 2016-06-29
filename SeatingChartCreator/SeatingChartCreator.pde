import controlP5.*;

import java.util.*;
import java.nio.file.*;
import java.io.*;
import javax.swing.JOptionPane;


//Created Jan. 4
//Alpha 1 completed Jan. 15


/* System requirements
JRE 7 (or 8?)
1024 x 768 resolution
Windows XP (latest service pack)
OS X 10.7.3
Linux
*/


/* Bugs (for all programs):
- ConcurrentModificationException issues - can sometimes occur while closing the window(?)
ClassCreator: no error message when file type is not recognized (class files only)
- Allows constraint distance to be greater than the size of the room
Duplicate students can appear?
Extra desks can appear
- OK button does not close the Excel dialog
- OK button in Excel dialog can be hidden (window height is too small)
Multiple Excel dialogs can be open - causes problems
Incorrect error if seating chart class file can not be found (error is also hidden behind desks)
Changing allowed desks not always applied
Damaged class files
*/



color backgroundColor = color(191, 255, 191);


void setup() {
  println("===============================");
  println("..:: Seating Chart Creator ::..");
  println("       Jacob van't Hoog");
  println("             2014");
  println("===============================");
  println();
  
  //768 - 64 = 704
  size(1024, 704);
  
  
  setupState();
  setupConstraints();
  setupGUI();
}


void draw() {
  background(backgroundColor);
  checkStateUpdates();
}


/*void test() {
  Student studentA = new Student("Student A", "", "", new GenderNone());
  Student studentB = new Student("Student B", "", "", new GenderNone());
  Student studentC = new Student("Student C", "", "", new GenderNone());
  studentA.addConstraint(new ProximityConstraint(2, false, studentB));
  studentC.addConstraint(new ProximityConstraint(3, false, studentA));
  studentC.addConstraint(new ProximityConstraint(1, false, studentB));
  for(int i = 0; i < 25; i++) {
    studentB.addConstraint(new ProximityConstraint(0, true, studentB));
  }
  currentStudentList.add(studentA);
  currentStudentList.add(studentB);
  currentStudentList.add(studentC);
  updateStudentList();
}*/