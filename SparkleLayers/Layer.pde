public abstract class Layer {
  
  protected PGraphics pg = null;
  
  public Layer(PGraphics pg) {
    this.pg = pg;
  }
  
  public abstract void draw();
 
  public void drawWithAlpha(float a) {
    tint(255, 255.0 * a);
    this.draw();
    noTint();
  }
  
  public abstract void setParam1(float v);
  public abstract void setParam2(float v);
  public abstract void setParam3(float v);

}