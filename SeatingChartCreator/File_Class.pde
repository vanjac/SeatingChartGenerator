final int classFileLines = 4;

interface ClassFileReader {
  public ClassGroup read(String file);
}

class GenericClassFileReader implements ClassFileReader {
  public ClassGroup read(String file) {
    println("Reading class excel file " + file);
    
    HSSFSheet sheet;
    try {
      POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(file));
      HSSFWorkbook wb = new HSSFWorkbook(fs);
      sheet = wb.getSheetAt(0);
    } catch (IOException ex) {
      println(ex);
      return null;
    }
    
    ClassGroup c = new ClassGroup();
    for(int i = 0; true; i++) {
      String firstName = "";
      String middleName = "";
      String lastName = "";
      String gender = "";
      
      HSSFRow r = sheet.getRow(i + 3);
      if(r == null)
        break;
      
      HSSFCell firstNameCell = r.getCell(0);
      if(firstNameCell == null)
        break;
      firstName = firstNameCell.getStringCellValue();
      if(firstName == null || firstName.isEmpty())
        break;
      
      HSSFCell middleNameCell = r.getCell(1);
      if(middleNameCell != null)
        middleName = middleNameCell.getStringCellValue();
      if(middleName == null)
        middleName = "";
      
      HSSFCell lastNameCell = r.getCell(2);
      if(lastNameCell != null)
        lastName = lastNameCell.getStringCellValue();
      if(lastName == null)
        lastName = "";
      
      HSSFCell genderCell = r.getCell(3);
      if(genderCell != null)
        gender = genderCell.getStringCellValue();
      if(gender == null)
        gender = "";
      
      Student s = new Student();
      s.setFirstName(firstName);
      s.setMiddleName(middleName);
      s.setLastName(lastName);
      switch(Character.toLowerCase(gender.concat(" ").charAt(0))) {
        case 'm':
          print("Male: ");
          s.setGender(new GenderMale());
          break;
        case 'f':
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