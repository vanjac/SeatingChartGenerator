interface ConstraintFileWriter {
  public boolean write(String file, String classFile, ClassGroup classGroup, SeatingArrangement arrangement);
}

class GenericConstraintFileWriter {
  public boolean write(String file, String classFile, ClassGroup classGroup, SeatingArrangement arrangement) {
    JSONObject json = new JSONObject();
    
    json.setString("classFile", classFile);
    json.setJSONArray("Student", createStudentArray(classGroup, arrangement));
    
    saveJSONObject(json, file);
    
    return true;
  }
  
  private JSONArray createStudentArray(ClassGroup classGroup, SeatingArrangement arrangement) {
    JSONArray studentArray = new JSONArray();
    
    int i = 0;
    for(Student s : classGroup.getStudents()) {
      studentArray.setJSONObject(i, createStudentObject(s, arrangement));
      
      i++;
    }
    
    return studentArray;
  }
  
  private JSONObject createStudentObject(Student student, SeatingArrangement arrangement) {
    JSONObject studentObject = new JSONObject();
    
    studentObject.setString("fullName", student.getName(NameStyle.FULL));
    studentObject.setJSONArray("Desk", createDeskArray(arrangement, student.getAllowedDesks(arrangement)));
    studentObject.setJSONArray("Constraint", createConstraintsArray(student.getConstraints()));
    
    return studentObject;
  }
  
  private JSONArray createDeskArray(SeatingArrangement arrangement, List<Desk> allowedDesks) {
    JSONArray deskArray = new JSONArray();
    
    int i = 0;
    for(Desk d : arrangement.getDesks()) {
      JSONObject deskObject = new JSONObject();
      deskObject.setInt("x", d.getX());
      deskObject.setInt("y", d.getY());
      deskObject.setBoolean("allowed", allowedDesks.contains(d));
      
      deskArray.setJSONObject(i, deskObject);
      i++;
    }
    
    return deskArray;
  }
  
  private JSONArray createConstraintsArray(List<SeatingConstraint> constraints) {
    JSONArray constraintArray = new JSONArray();
    
    int i = 0;
    for(SeatingConstraint c : constraints) {
      JSONObject constraintObject = c.createJSON();
      
      constraintArray.setJSONObject(i, constraintObject);
      i++;
    }
    
    return constraintArray;
  }
  
  
}
