public class StrobeLayer extends Layer {
  private int i = 0;
  private int imod = 1;
  private int imodLimit = 1; //todo map this to knob
  private float c = 50;
  
  public StrobeLayer(PGraphics pg) {
    super(pg);
  }
  
  public void draw() {
    this.pg.beginDraw();
    this.pg.background(0,0);
    colorMode(HSB, 100);
    if (i % imod < imodLimit) {
      this.pg.fill(color(c, 100, 80));
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
  
  public void setParam1(float v){
    imod = int(map(v, 0.0, 1.0, 2, 10)); //range might need to be tweaked
    //this controls how long darkness is.
  }
  public void setParam2(float v){ 
    imodLimit = int(map(v, 0.0, 1.0, 1, imod));
    //this basically controls how long the strobe stays illuminated. larger number, more frames of brightness
    //at max, when imodLimit == imod, strobe will always be illuminated
    
  }
  public void setParam3(float v){
    c = map(v, 0.0, 1.0, 0, 100);
  }

}
