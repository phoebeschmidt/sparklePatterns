public class WavesLayer extends Layer {
  
  public WavesLayer(PGraphics pg) {
    super(pg);
  }
  
  public void draw() {
    this.pg.beginDraw();
    this.pg.background(0, 255,  0);
    this.pg.endDraw();
    image(pg, 0, 0);
  }
 
  public void setParam1(float v) {
    return;
  }
  public void setParam2(float v) {
    return;
  }
  public void setParam3(float v) {
    return;
  }

}