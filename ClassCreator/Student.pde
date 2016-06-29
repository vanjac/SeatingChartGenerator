import java.util.*;

interface Named {
  public String getFirstName();
  public String getMiddleName();
  public String getLastName();
  
  public String setFirstName(String name);
  public String setMiddleName(String name);
  public String setLastName(String name);
  
  public String getName(NameStyle style);
}


class Student implements Named {
  private String firstName;
  private String middleName;
  private String lastName;
  private Gender gender;
  
  public Student() {
    firstName = "";
    middleName = "";
    lastName = "";
    gender = new GenderNone();
  }
  
  public Student(String n1, String n2, String n3, Gender g) {
    setFirstName(n1);
    setMiddleName(n2);
    setLastName(n3);
    gender = g;
  }
  
  public Gender getGender() {
    return gender;
  }
  
  public Gender setGender(Gender g) {
    return gender = g;
  }
  
  public String getFirstName() {
    return firstName;
  }
  
  public String setFirstName(String name) {
    return firstName = name;
  }
  
  public String getMiddleName() {
    return middleName;
  }
  
  public String setMiddleName(String name) {
    return middleName = name;
  }
  
  public String getLastName() {
    return lastName;
  }
  
  public String setLastName(String name) {
    return lastName = name;
  }
  
  public String getName(NameStyle style) {
    return style.formatName(firstName, middleName, lastName);
  }
}
