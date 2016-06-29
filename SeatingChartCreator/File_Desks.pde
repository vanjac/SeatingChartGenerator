interface DeskFileReader {
  public SeatingArrangement read(File f);
}

final float brightnessThreshold = 127;

class GenericDeskFileReader {
  public SeatingArrangement read(String file) {
    println("Reading desk file " + file);
    colorMode(RGB, 255);
    
    PImage image = loadImage(file);
    
    if(image == null) {
      println("Not a valid image file.");
      return null;
    }
    
    SeatingArrangement arrangement = new SeatingArrangement(image.width, image.height);
    
    println();
    for(int y = 0; y < image.height; y++) {
      for(int x = 0; x < image.width; x++) {
        color c = image.get(x, y);
        if(brightness(c) <= brightnessThreshold) {
          print("*");
          arrangement.setDesk(new Desk(arrangement), x, y);
        } else {
          print(" ");
        }
      }
      println();
    }
    
    println("Done reading file.");
    return arrangement;
  }
}
