public class StrobeLayer extends Layer {
  private int i = 0;
  private int imod = 40;
  private int imodLimit = 20; //todo map this to knob
  private float c = 50;
  
  public StrobeLayer(PGraphics pg) {
    super(pg);
  }
  
  public void draw() {
    this.pg.beginDraw();
    this.pg.background(0,0);
    colorMode(HSB, 100);
    this.pg.fill(color(c, 100, 100));
    if (i % imod < 100) {
      this.pg.fill(100);
      this.pg.rect(0, 0, width, height);
    } else {
      this.pg.fill(0);
      this.pg.rect(0, 0, width, height);
    }
    i = i + 1;
    this.pg.endDraw();
    image(pg, 0, 0);
    colorMode(RGB, 255);
  }
  
  public void setParam1(int v){
    imodLimit = int(map(v / 1.0, 0.0, 127.0, 0, 40)); //range might need to be tweaked
  }
  public void setParam2(int v){
    c = map(v / 1.0, 0.0, 127.0, 0, 100);
  }
  public void setParam3(int v){}

}
