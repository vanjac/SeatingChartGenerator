class ListRandomizer<E> {
  public List<E> randomize(List<E> list) {
    println("Randomize list");
    
    List<E> oldList = new ArrayList<E>(list);
    list = new ArrayList<E>(list);
    int listSize = list.size();
    
    List<E> newList = new ArrayList<E>(list.size());
    while(!list.isEmpty()) {
      int i = floor(random(list.size()));
      newList.add(list.get(i));
      list.remove(i);
    }
    
    if(newList.size() != listSize)
      println("ERROR: Randomized list size (" + newList.size() + ") doesn't match original list size (" + listSize + ")" );
    
    if(oldList.equals(newList))
      println("WARNING: Randomized list and original list are equal");
    
    return newList;
  }
}


interface Randomizer {
  public SeatingArrangement randomize(SeatingArrangement arrangement, List<Student> students, boolean randomizeDesks, boolean reverseDesks);
}


class GenericRandomizer implements Randomizer {
  private int counter;
  private final int counterLimit = 4096;
  
  public SeatingArrangement randomize(SeatingArrangement arrangement, List<Student> students, boolean randomizeDesks, boolean reverseDesks) {
    println("Randomizing...");
    
    counter = 0;
    
    students = new ArrayList<Student>(students);
    
    arrangement = arrangement.copy(false); //Needs to be false, otherwise desks can't be compared to each other
    List<Desk> desks = getEmptyDesks(arrangement);
    
    students = new ListRandomizer<Student>().randomize(students);
    
    if(randomizeDesks) {
      println("Randomize desks");
      desks = new ListRandomizer<Desk>().randomize(desks);
    }
    if(reverseDesks) {
      println("Reverse desks");
      Collections.reverse(desks);
    }
    
    
    println();
    return randomizeRecursive(arrangement, students, desks);
  }
  
  
  private List<Desk> getEmptyDesks(SeatingArrangement a) {
    println("Get empty desks...");
    
    List<Desk> desks = new ArrayList<Desk>();
    for(Desk d : a.getDesks()) {
      //println("Here's a desk");
      if(d.getStudent() == null) {
        desks.add(d);
        //println("It's empty");
      }
    }
    
    println();
    return desks;
  }
  
  
  private SeatingArrangement randomizeRecursive(SeatingArrangement a, List<Student> remainingStudents, List<Desk> remainingDesks) {
    //println("Randomize recursive...");
    
    if(counter++ >= counterLimit) {
      //println("Randomizing took too long! Stopping and returning null.");
      return null;
    }
    
    if(remainingStudents.isEmpty()) {
      //println("Student list empty, returning");
      return a;
    }
    
    if(remainingDesks.isEmpty()) {
      //println("Desk list empty, returning");
      return a;
    }
    
    
    a = a.copy(false); //Needs to be false, otherwise desks can't be compared to each other
    
    for(Student s : remainingStudents) {
      //println("Testing student: " + s.getName(NameStyle.FULL));
      
      List<Desk> allowedDesks = s.getAllowedDesks(a);
      allowedDesks = new ArrayList<Desk>(allowedDesks);
      
      List<Desk> remainingDesksTemp = new ArrayList<Desk>(remainingDesks);
      remainingDesksTemp.retainAll(allowedDesks);
      allowedDesks = remainingDesksTemp;
      remainingDesksTemp = null;
      
      if(allowedDesks.isEmpty()) {
        //println("No allowed desks. Skipping this student.");
        continue;
      }
      
      //println(allowedDesks.size() + " desks to test");
      
      
      for(Desk d : allowedDesks) {
        //println("Testing...");
        d.setStudent(s);
        if(satisfiesConstraints(a)) {
          //println("Satisfies Constraints");
          List<Student> sl = new ArrayList<Student>(remainingStudents);
          sl.remove(s);
          List<Desk> dl = new ArrayList<Desk>(remainingDesks);
          dl.remove(d);
          SeatingArrangement result = randomizeRecursive(a, sl, dl);
          if(result != null)
            return result;
        } else {
          //println("Does not satisfy constraints");
        }
        d.setStudent(null);
      }
      
      //println("No desks worked, trying next student...");
      println();
    }
    
    //println("Nothing worked, returning null.");
    return null;
  }
  
  
  private boolean satisfiesConstraints(SeatingArrangement a) {
    for(Desk d : a.getDesks()) {
      if(d.getStudent() == null)
        continue;
      if(!d.getStudent().satisfiesConstraints(d))
        return false;
    }
    
    return true;
  }
}
