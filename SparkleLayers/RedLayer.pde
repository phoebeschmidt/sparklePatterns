public class RedLayer extends Layer {
  
  float i = 0;
  Integer squareSize = 40;
  
  public RedLayer(PGraphics pg) {
    super(pg);
  }
  
  public void draw() {
    pg.beginDraw();
    pg.background(0, 0);
    pg.fill(255, 0, 0);
    pg.noStroke();
    pg.rect(30, (sin(i) * pg.height / 2) + pg.height/2, squareSize, squareSize);
    pg.endDraw();
    i += .01;
    image(pg, 0,0);
  }
  
  public void setParam1(int v) {
    squareSize = Math.round(map(v / 1.0, 0.0, 127.0, 20.0, 60.0));
  }
  public void setParam2(int v){}
  public void setParam3(int v){}

}