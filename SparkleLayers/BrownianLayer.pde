public class BrownianLayer extends Layer {
  
  float i = 0;
  Integer squareSize = 10;
  float[][] squares; 
  float range = 2.0;
  // Variables for timer
  int interval = 5;
  int lastRecordedTime = 0;

  public BrownianLayer(PGraphics pg) {
    super(pg);
    squares = new float[12][30];
    for (int x=0; x<12; x++) {
      for (int y=0; y<30; y++) {
        float state = random(100.0);
        squares[x][y] = state; // Save state of each cell
      }
    }    

  }
  
  public void draw() {
    pg.beginDraw();
    this.pg.background(0,0);
    colorMode(HSB, 100);
    
    //Draw grid
    for (int x=0; x<12; x++) {
      for (int y=0; y<30; y++) {
        pg.fill(color(40, 100, squares[x][y]));
        pg.rect(x * squareSize, y*squareSize, squareSize, squareSize);
      }
    }
        // Iterate if timer ticks
    if (millis()-lastRecordedTime > interval) {
      for (int x=0; x<12; x++) {
        for (int y=0; y<30; y++) {
          int update =  int(random(-range, range));
          squares[x][y] = squares[x][y] + update;
          squares[x][y] = constrain(squares[x][y], 0.0, 100.0);
        }
      }
      lastRecordedTime = millis();

    }


    pg.endDraw();
    image(pg, 0,0);
    colorMode(RGB, 255);

  }
  
  public void setParam1(float v) {
  }
  public void setParam2(float v){}
  public void setParam3(float v){}

}