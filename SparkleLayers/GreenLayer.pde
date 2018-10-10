public class GreenLayer extends Layer {
  
  public GreenLayer(PGraphics pg) {
    super(pg);
  }
  
  public void draw() {
    this.pg.beginDraw();
    this.pg.background(0, 255,  0);
    this.pg.endDraw();
    image(pg, 0, 0);
  }
  
  public void setParam1(int v){}
  public void setParam2(int v){}
  public void setParam3(int v){}

}