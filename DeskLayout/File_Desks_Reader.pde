interface DeskFileReader {
  boolean[][] read(String file);
}

final float brightnessThreshold = 127;

class GenericDeskFileReader implements DeskFileReader {
  public boolean[][] read(String file) {
    println("Reading desk file " + file);
    
    PImage deskImage = loadImage(file);
    
    if(deskImage == null) {
      println("Not a valid image file.");
      return null;
    }
    
    boolean[][] desks = new boolean[deskImage.width][deskImage.height];
    
    println();
    for(int y = 0; y < deskImage.height; y++) {
      for(int x = 0; x < deskImage.width; x++) {
        color c = deskImage.get(x, y);
        if(brightness(c) <= brightnessThreshold) {
          desks[x][y] = true;
        } else {
          desks[x][y] = false;
        }
      }
      println();
    }
    
    println("Done reading file.");
    return desks;
  }
}