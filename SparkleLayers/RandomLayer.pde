public class RandomLayer extends Layer {
  private float rectWidth = 0;
  private float rectHeight = 0;
  private float x = 0;
  private float y = 0;
  private float skipMod = 0;
  private float skipModMax = 5; //TODO this maps to a knob
  private float i = 0;
  private float c = 50;
  
  public RandomLayer(PGraphics pg) {
    super(pg);
  }
  
  public void draw() {
    this.pg.beginDraw();
    this.pg.background(0,0);
    colorMode(HSB, 100);
    this.pg.fill(color(c, 100, 100));
    if (i % skipMod > (skipModMax/2)) {
      rectWidth = random(5);
      rectHeight = random(4);
      x = random(width);
      y = random(height);
      this.pg.rect(x, y, rectWidth * 12, rectHeight * 30);
    }
    skipMod = random(5);
    i = i+1;
    this.pg.endDraw();
    image(pg, 0, 0);
    colorMode(RGB, 255);
  }
  
  public void setParam1(float v){
    skipModMax = map(v / 1.0, 0.0, 127.0, 0, 6); //range might need to be tweaked
  }
  public void setParam2(float v){
    c = map(v / 1.0, 0.0, 127.0, 0, 100);
  }
  public void setParam3(float v){}

}
