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

}