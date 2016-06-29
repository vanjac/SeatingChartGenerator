final int lines = 4;

interface ClassFileReader {
  public List<Student> read(String file);
}

class GenericClassFileReader implements ClassFileReader {
  public List<Student> read(String file) {
    println("Reading class file " + file);
    String[] stringList = loadStrings(file);
    
    println(stringList.length / lines + " students found.");
    
    List<Student> studentList = new ArrayList<Student>();
    
    for(int i = 0; i < stringList.length; i += lines) {
      if(i+3 >= stringList.length) {
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
      
      studentList.add(s);
      println(s.getName(NameStyle.FULL));
    }
    
    println("Done reading file.");
    return studentList;
  }
}
