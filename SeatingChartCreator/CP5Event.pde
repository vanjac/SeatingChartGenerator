List<CP5Event> eventActions;

void setupEvents() {
  eventActions = new ArrayList<CP5Event>();
}

void addEvent(Object o, CP5EventAction a) {
  eventActions.add(new CP5Event(o, a));
}


void controlEvent(ControlEvent event) {
  println("ControlEvent: " + event.toString());
  for(CP5Event e : eventActions) {
    e.runIfMatch(event);
  }
}

class CP5Event {
  private Object control;
  private CP5EventAction action;
  
  public CP5Event(Object c, CP5EventAction a) {
    control = c;
    action = a;
  }
  
  public void run(ControlEvent e) {
    println("Running action");
    action.run(e);
  }
  
  public void runIfMatch(ControlEvent e) {
    Object o = null;
    if(e.isController())
      o = e.getController();
    if(e.isGroup())
      o = e.getGroup();
    if(e.isTab())
      o = e.getTab();
    
    if(o == control) {
      println("Matched action");
      run(e);
    }
  }
}

interface CP5EventAction {
  public void run(ControlEvent c);
}
