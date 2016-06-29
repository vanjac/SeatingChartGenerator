interface ConstraintFileReader {
  public String readClass(String file);
  public SeatingArrangement readDesks(String file);
  public boolean addConstraints(String file, List<Student> studentList, SeatingArrangement arrangement, List<ConstraintType> constraints);
}

class GenericConstraintFileReader implements ConstraintFileReader {
  public String readClass(String file) {
    println("Reading class from constraint file " + file);
    JSONObject json;
    try {
      json = loadJSONObject(file);
      if(json == null)
        return null;
    } catch (RuntimeException e) {
      return null;
    }
    
    return json.getString("classFile");
  }
  
  public SeatingArrangement readDesks(String file) {
    println("Reading desks from constraint file " + file);
    JSONObject json;
    try {
      json = loadJSONObject(file);
      if(json == null)
        return null;
    } catch (RuntimeException e) {
      return null;
    }
    JSONArray studentArray = json.getJSONArray("Student");
    if(studentArray == null)
      return null;
    JSONObject firstStudent = studentArray.getJSONObject(0);
    if(firstStudent == null)
      return null;
    JSONArray deskArray = firstStudent.getJSONArray("Desk");
    if(deskArray == null)
      return null;
    
    SeatingArrangement arrangement = new SeatingArrangement(getXSize(deskArray), getYSize(deskArray));
    println("Seating chart size: (" + arrangement.getXSize() + ", " + arrangement.getYSize() + ")");
    
    for(int i = 0; i < deskArray.size(); i++) {
      JSONObject deskObject = deskArray.getJSONObject(i);
      addDesk(deskObject, arrangement);
    }
    
    return arrangement;
  }
  
  private int getXSize(JSONArray deskArray) {
    int maxValue = 0;
    
    for(int i = 0; i < deskArray.size(); i++) {
      JSONObject deskObject = deskArray.getJSONObject(i);
      int value = deskObject.getInt("x");
      if(value > maxValue)
        maxValue = value;
    }
    
    return maxValue + 1;
  }
  
  private int getYSize(JSONArray deskArray) {
    int maxValue = 0;
    
    for(int i = 0; i < deskArray.size(); i++) {
      JSONObject deskObject = deskArray.getJSONObject(i);
      int value = deskObject.getInt("y");
      if(value > maxValue)
        maxValue = value;
    }
    
    return maxValue + 1;
  }
  
  private void addDesk(JSONObject deskObject, SeatingArrangement arrangement) {
    Desk d = new Desk(arrangement);
    int x = deskObject.getInt("x");
    int y = deskObject.getInt("y");
    
    arrangement.setDesk(d, x, y);
  }
  
  
  
  public boolean addConstraints(String file, List<Student> studentList, SeatingArrangement arrangement, List<ConstraintType> constraints) {
    println("Reading constraints from constraint file " + file);
    JSONObject json;
    try {
      json = loadJSONObject(file);
      if(json == null)
        return false;
    } catch (RuntimeException e) {
      return false;
    }
    JSONArray studentArray = json.getJSONArray("Student");
    if(studentArray == null)
      return false;
    
    for(int i = 0; i < studentArray.size(); i++) {
      JSONObject studentObject = studentArray.getJSONObject(i);
      if(!readStudentObject(studentObject, studentList, arrangement, constraints))
        return false;
    }
    
    
    return true;
  }
  
  private boolean readStudentObject(JSONObject studentObject, List<Student> studentList, SeatingArrangement arrangement, List<ConstraintType> constraints) {
    String fullName = studentObject.getString("fullName");
    Student s = findStudent(fullName, studentList);
    if(s == null)
      return false;
    
    JSONArray deskArray = studentObject.getJSONArray("Desk");
    if(deskArray == null)
      return false;
    for(int i = 0; i < deskArray.size(); i++) {
      JSONObject deskObject = deskArray.getJSONObject(i);
      if(!readDeskObject(deskObject, s, arrangement))
        return false;
    }
    
    JSONArray constraintArray = studentObject.getJSONArray("Constraint");
    if(constraintArray == null)
      return false;
    for(int i = 0; i < constraintArray.size(); i++) {
      JSONObject constraintObject= constraintArray.getJSONObject(i);
      if(!readConstraintObject(constraintObject, s, constraints))
        return false;
    }
    
    return true;
  }
  
  private boolean readDeskObject(JSONObject deskObject, Student student, SeatingArrangement arrangement) {
    int x = deskObject.getInt("x");
    int y = deskObject.getInt("y");
    
    Desk d = arrangement.getDesk(x, y);
    if(d == null)
      return false;
    
    boolean allowed = deskObject.getBoolean("allowed");
    
    if(allowed) {
      student.allowDesk(d);
    } else {
      student.banDesk(d);
    }
    
    return true;
  }
  
  private boolean readConstraintObject(JSONObject constraintObject, Student student, List<ConstraintType> constraints) {
    String type = constraintObject.getString("type");
    
    ConstraintType constraintType = findConstraint(type, constraints);
    if(constraintType == null)
      return false;
    
    SeatingConstraint constraint = constraintType.createFromJSON(constraintObject);
    if(constraint == null)
      return false;
    student.addConstraint(constraint);
    
    return true;
  }
  
  private ConstraintType findConstraint(String name, List<ConstraintType> constraints) {
    for(ConstraintType c : constraints) {
      String cName = c.toString();
      if(cName.equals(name))
        return c;
    }
    
    return null;
  }
}
