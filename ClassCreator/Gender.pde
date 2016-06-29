interface Gender {
  String toString();
  char toChar();
  int toInt();
}

class GenderNone implements Gender {
  String toString() {
    return "none";
  }
  
  char toChar() {
    return 'N';
  }
  
  int toInt() {
    return 0;
  }
}

class GenderMale implements Gender {
  String toString() {
    return "male";
  }
  
  char toChar() {
    return 'M';
  }
  
  int toInt() {
    return 1;
  }
}

class GenderFemale implements Gender {
  String toString() {
    return "female";
  }
  
  char toChar() {
    return 'F';
  }
  
  int toInt() {
    return 2;
  }
}
