List<ConstraintType> constraints;


interface SeatingConstraint {
  public boolean satisfiesConstraint(Desk d);
  
  public String toString();
  
  public List<ControllerInterface> createGUI(ControlP5 cp5, Group g);
  
  public JSONObject createJSON();
}

interface ConstraintType {
  public String toString();
  public boolean matchesType(SeatingConstraint c);
  public SeatingConstraint create();
  public SeatingConstraint createFromJSON(JSONObject json);
}


void setupConstraints() {
  constraints = new ArrayList<ConstraintType>();
}


class ProximityConstraint implements SeatingConstraint {
  
  public String toString() {
    return null;
  }
  
  public boolean satisfiesConstraint(Desk d) {
    return false;
  }
  
  public int getDistance() {
    return 0;
  }
  
  public int setDistance(int d) {
    return d;
  }
  
  public boolean getMode() {
    return false;
  }
  
  public boolean setMode(boolean m) {
    return m;
  }
  
  public Student getStudent() {
    return null;
  }
  
  public Student setStudent(Student s) {
    return s;
  }
  
  public JSONObject createJSON() {
    return null;
  }
  
  public List<ControllerInterface> createGUI(ControlP5 cp5, Group g) {
    return null;
  }
}
