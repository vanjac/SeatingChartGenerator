import java.awt.event.*;

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  String[] args = {theName};
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  PApplet.runSketch(args, p);
  
  return p;
}

public class ControlFrame extends PApplet {

  int w, h;
  ControlP5 cp5;
  Object parent;
  color background;
  
  List<CP5Event> eventActions;
  
  void addEvent(Object o, CP5EventAction a) {
    eventActions.add(new CP5Event(o, a));
  }
  
  public void settings() {
    size(w, h);
  }
  
  // prevent closing the dialog
  public void stop() {
    
  }
  
  public ControlP5 cp5() {
    return cp5;
  }

  public void draw() {
      background(background);
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
    background = color(0);
    eventActions = new ArrayList<CP5Event>();
  }
  
  void controlEvent(ControlEvent event) {
    println("ControlEvent: " + event.toString());
    for(CP5Event e : eventActions) {
      e.runIfMatch(event);
    }
  }
  
  public void setupGUI() {
    cp5 = new ControlP5(this);
  }
  
  public void setBackground(color c) {
    background = c;
  }


  public ControlP5 control() {
    return cp5;
  }
}