import java.awt.event.*;

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  String[] args = {theName};
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  PApplet.runSketch(args, p);
  
  //Frame f = new Frame(theName);
  //ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  //f.add(p);
  //p.init();
  //f.setTitle(theName);
  //f.setSize(p.w, p.h);
  //if(frame != null) {
  //  f.setLocation(frame.getX() - 16, frame.getY() - 16);
  //} else {
  //  f.setLocation(100, 100);
  //}
  //f.setResizable(false);
  //f.setVisible(true);
  return p;
}

// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;
  ControlP5 cp5;
  Object parent;
  color background;
  //Frame f;
  
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
  
  public void setup() {
    
    //f = (Frame)getAccessibleContext().getAccessibleParent();
    //f.addWindowListener(new WindowListener() {
    //  public void windowActivated(WindowEvent arg0) {
    //    // TODO Auto-generated method stub
        
    //  }
      
    //  public void windowClosed(WindowEvent e) {
    //    // TODO Auto-generated method stub
        
    //  }
      
      
    //  public void windowClosing(WindowEvent e) {
    //    // TODO Auto-generated method stub
    //    println("close");
    //    f.setVisible(false);
    //  }
      
    //  public void windowDeactivated(WindowEvent e) {
    //    // TODO Auto-generated method stub
        
    //  }
      
    
    //  public void windowDeiconified(WindowEvent e) {
    //    // TODO Auto-generated method stub
        
    //  }
      
    
    //  public void windowIconified(WindowEvent e) {
    //    // TODO Auto-generated method stub
        
    //  }
    
    //  public void windowOpened(WindowEvent e) {
    //    // TODO Auto-generated method stub
        
    //  }
    //});
  }
  
  public ControlP5 cp5() {
    return cp5;
  }

  public void draw() {
      background(background);
  }
  
  private ControlFrame() {
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