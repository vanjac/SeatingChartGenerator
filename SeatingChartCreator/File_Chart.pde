final int chartFileLines = 3;


interface SeatingChartFileReader {
  public String readClass(String file);
  public SeatingArrangement read(String file, List<Student> studentList);
}


class GenericSeatingChartFileReader implements SeatingChartFileReader {
  public String readClass(String file) {
    println("Reading class from seating chart file " + file);
    String[] stringList = loadStrings(file);
    return stringList[0];
  }
  
  public SeatingArrangement read(String file, List<Student> studentList) {
    println("Reading seating chart file " + file);
    String[] stringList = loadStrings(file);
    
    if(stringList == null)
      return null;
    if(stringList.length == 0)
      return null;
    
    //List<Student> studentList = c.getStudents();
    
    SeatingArrangement arrangement = null;
    
    try {
      arrangement = new SeatingArrangement(Integer.parseInt(stringList[1]), Integer.parseInt(stringList[2]));
    } catch (NumberFormatException e) {
      return null;
    }
    
    for(int i = 3; i < stringList.length; i += 3) {
      if(i+(chartFileLines - 1) >= stringList.length) {
        println("WARNING: Unexpected number of lines. Skipping last desk.");
        break;
      }
      
      println("Reading desk: (" + stringList[i] + ", " + stringList[i+1] + "): " + stringList[i+2]);
      
      Desk d = new Desk(arrangement);
      
      try {
        arrangement.setDesk(d, Integer.parseInt(stringList[i]), Integer.parseInt(stringList[i+1]));
      } catch (NumberFormatException e) {
        return null;
      }
      
      String studentName = stringList[i+2];
      if(studentName.isEmpty())
        continue;
      
      Student s = findStudent(studentName, studentList);
      if(s == null) {
        println("ERROR: Could not match student " + studentName + ". Skipping this student.");
        continue;
      }
      
      d.setStudent(s);
      studentList.remove(s);
    }
    
    
    return arrangement;
  }
  
}





interface SeatingChartFileWriter {
  public boolean write(String file, String classFile, SeatingArrangement arrangement);
}

class GenericSeatingChartFileWriter implements SeatingChartFileWriter {
  public boolean write(String file, String classFile, SeatingArrangement arrangement){
    println("Writing seating chart file " + file);
    
    if(arrangement == null) {
      println("No desk arrangement loaded");
      return false;
    }
    
    List<Desk> deskList = arrangement.getDesks();
    
    if(classFile == null) {
      println("No class file loaded");
      return false;
    }
    if(classFile.isEmpty()) {
      println("No class file loaded");
      return false;
    }
    if(deskList == null) {
      println("No desk arrangement loaded");
      return false;
    }
    if(deskList.isEmpty()) {
      println("No desk arrangement loaded");
      return false;
    }
    
    List<String> stringList = new ArrayList<String>();
    stringList.add(classFile);
    stringList.add(str(arrangement.getXSize()));
    stringList.add(str(arrangement.getYSize()));
    
    for(Desk d : deskList) {
      stringList.add(str(d.getX()));
      stringList.add(str(d.getY()));
      String studentName = "";
      if(d.getStudent() != null) {
        studentName = d.getStudent().getName(NameStyle.FULL);
      }
      stringList.add(studentName);
    }
    
    saveStrings(file, stringList.toArray(new String[stringList.size()]));
    return true;
  }
}
