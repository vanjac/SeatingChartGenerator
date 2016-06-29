final int classFileLines = 4;

interface ClassFileReader {
  public ClassGroup read(String file);
}

class GenericClassFileReader implements ClassFileReader {
  public ClassGroup read(String file) {
    println("Reading class file " + file);
    String[] stringList = loadStrings(file);
    
    if(stringList == null)
      return null;
    if(stringList.length == 0)
      return null;
    
    println(stringList.length / classFileLines + " students found.");
    
    ClassGroup c = new ClassGroup();
    for(int i = 0; i < stringList.length; i += classFileLines) {
      if(i+(classFileLines - 1) >= stringList.length) {
        println("WARNING: Unexpected number of lines. Skipping last student.");
        break;
      }
      
      Student s = new Student();
      s.setFirstName(stringList[i]);
      s.setMiddleName(stringList[i+1]);
      s.setLastName(stringList[i+2]);
      switch(stringList[i+3].concat(" ").charAt(0)) {
        case 'M':
          print("Male: ");
          s.setGender(new GenderMale());
          break;
        case 'F':
          print("Female: ");
          s.setGender(new GenderFemale());
          break;
        default:
          print("No gender: ");
          s.setGender(new GenderNone());
      }
      
      c.addStudent(s);
      println(s.getName(NameStyle.FULL));
    }
    
    println("Done reading file.");
    return c;
  }
}
