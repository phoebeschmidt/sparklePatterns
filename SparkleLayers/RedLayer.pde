public class RedLayer extends Layer {
  
  float i = 0;
  
  public RedLayer(PGraphics pg) {
    super(pg);
  }
  
  public void draw() {
    pg.beginDraw();
    pg.background(0, 0);
    pg.fill(255, 0, 0);
    pg.noStroke();
    pg.rect(30, (sin(i) * pg.height / 2) + pg.height/2, 40, 40);
    pg.endDraw();
    i += .1;
    image(pg, 0,0);
  }
  
}