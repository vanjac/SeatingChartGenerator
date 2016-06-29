import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.poifs.filesystem.*;
import java.io.FileInputStream;
import java.util.*;
//import java.awt.Frame;
//import java.awt.BorderLayout;

import controlP5.*;


color backgroundColor = color(255, 255, 191);

void settings() {
  size(384, 704);
}

void setup() {
  println("=======================");
  println("..:: Class Creator ::..");
  println("   Jacob van't Hoog");
  println("         2014");
  println("=======================");
  
  registerMethod("pre", this);
  
  setupState();
  setupGUI();
  updateStudents();
}


void draw() {
  background(backgroundColor);
}


void pre() {
  checkStateUpdates();
}


PApplet applet() {
  return this;
}

//static void main(String[] args) {
//  
//}