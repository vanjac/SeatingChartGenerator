ControlP5 cp5;

Matrix mtxDesks;

Button btnClear;
Button btnLoad;
Button btnSave;

Map<Integer, PVector> deskPositions;

final int xLen = 24;
final int yLen = 20;
final int xStart = 0;
final int yStart = 48;
final int deskSize = 32;


void setupGUI() {
  println("Setup GUI...");
  
  cp5 = new ControlP5(this);
  
  setupEvents();
  
  mtxDesks = cp5.addMatrix("desks")
    .setPosition(xStart, yStart)
    .setSize(xLen*deskSize, yLen*deskSize)
    .setGrid(xLen, yLen)
    .setMode(ControlP5.MULTIPLES)
    .set(0, 0, true)
    .setInterval(0)
//    .pause()
    ;
  
  setupFilePanel();
}


void setupFilePanel() {
  btnClear = cp5.addButton("Clear")
    .setPosition(0, 0)
    .setSize(64, 32)
    ;
  addEvent(btnClear, new CP5EventAction() {
    public void run(ControlEvent e) {
      mtxDesks.clear();
    }
  });
  
  btnLoad = cp5.addButton("Load")
    .setPosition(64, 0)
    .setSize(64, 32)
    ;
  addEvent(btnLoad, new CP5EventAction() {
    public void run(ControlEvent e) {
      selectInput("Choose a desk layout file...", "fileLoaded");
    }
  });
  
  btnSave = cp5.addButton("Save")
    .setPosition(128, 0)
    .setSize(64, 32)
    ;
  addEvent(btnSave, new CP5EventAction() {
    public void run(ControlEvent e) {
      selectOutput("Choose a file to save to...", "fileSaved");
    }
  });
}



void desks(int x, int y) {
  mtxDesks.pause();
  mtxDesks.clear();
}


// ..:: Files ::..
void fileLoaded(File f) {
  if(f == null)
    return;
  
  boolean[][] desks = new GenericDeskFileReader().read(f.toString());
  
  if(desks == null)
    return;
  
  mtxDesks.clear();
  for(int y = 0; y < desks[0].length; y++) {
    for(int x = 0; x < desks.length; x++) {
      mtxDesks.set(x, y, desks[x][y]);
    }
  }
}


void fileSaved(File f) {
  if(f == null)
    return;
  
  String fileName = f.toString();
  if(!fileName.endsWith(".png"))
    fileName = fileName + ".png";
  
  boolean[][] desks = new boolean[xLen][yLen];
  println();
  for(int y = 0; y < yLen; y++) {
    for(int x = 0; x < xLen; x++) {
      boolean value = mtxDesks.get(x, y);
      desks[x][y] = value;
      
      if(value) {
        print("*");
      } else {
        print(" ");
      }
    }
    println();
  }
  
  boolean result = new GenericDeskFileWriter().write(fileName, desks);
}
