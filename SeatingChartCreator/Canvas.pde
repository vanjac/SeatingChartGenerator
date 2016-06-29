class DrawCanvas extends Canvas {
  List<CDrawable> drawnObjects;
  
  public void add(CDrawable d) {
    drawnObjects.add(d);
  }
  
  public DrawCanvas() {
    drawnObjects = new ArrayList<CDrawable>();
  }
  
  public void draw(PGraphics a) {
    for(CDrawable d : drawnObjects) {
      d.draw(a);
    }
  }
}


class Rectangle implements CDrawable {
  int xPos;
  int yPos;
  int xLen;
  int yLen;
  color fill;
  color stroke;
  
  public Rectangle(int _xPos, int _yPos, int _xLen, int _yLen, color _fill, color _stroke) {
    xPos = _xPos;
    yPos = _yPos;
    xLen = _xLen;
    yLen = _yLen;
    fill = _fill;
    stroke = _stroke;
  }
  
  public void draw(PGraphics applet) {
    fill(fill);
    stroke(stroke);
    rectMode(CORNER);
    rect(xPos, yPos, xLen, yLen);
  }
}