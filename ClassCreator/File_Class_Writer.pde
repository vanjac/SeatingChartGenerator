interface ClassFileWriter {
  public boolean write(String file, List<Student> students);
}

class GenericClassFileWriter {
  public boolean write(String file, List<Student> students) {
    println("Writing class file " + file);
    
    List<String> stringList = new ArrayList<String>(students.size() * lines);
    
    for(Student s : students) {
      stringList.add(s.getName(NameStyle.FIRST));
      stringList.add(s.getName(NameStyle.MIDDLE));
      stringList.add(s.getName(NameStyle.LAST));
      stringList.add(String.valueOf(s.getGender().toChar()));
    }
    
    saveStrings(file, stringList.toArray(new String[0]));
    return true;
  }
}
