import controlP5.*;
import seatingchart.*;

import java.util.*;


color backgroundColor = color(127, 127, 127);


void setup() {
  println("============================");
  println("..::Desk Layout Designer::..");
  println("      Jacob van't Hoog");
  println("            2014");
  println("============================");
  
  //24*32 = 768
  //20*32 + 32 = 672
  size(768, 704);
  setupGUI();
}


void draw() {
  background(backgroundColor);
}