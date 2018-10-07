public class GreenLayer extends Layer {
  float dx, dy;

  public GreenLayer(PGraphics pg) {
    super(pg);
  }
  
  public void draw() {
    
  }
  
  public void drawWithAlpha(float a) {
    this.pg.beginDraw();
    this.pg.background(0,0);
    long now = millis();
    float speed = 0.002;
    float angle = sin(now * 0.001);
    float z = now * 0.00008;
    float hue = now * 0.01;
    float scale = 0.005;
    
    dx += cos(angle) * speed;
    dy += sin(angle) * speed;

    this.pg.loadPixels();
    for (int x=0; x < this.pg.width; x++) {
      for (int y=0; y < this.pg.height; y++) {
       
        float n = this.fractalNoise(dx + x*scale, dy + y*scale, z) - 0.75;
        float m = this.fractalNoise(dx + x*scale, dy + y*scale, z + 10.0) - 0.75;
  
        color c = color(
           a * ((hue + 80.0 * m) % 100.0),
           a * (100 - 100 * constrain(pow(3.0 * n, 3.5), 0, 0.9)),
           a * (100 * constrain(pow(3.0 * n, 1.5), 0, 0.9))
           );
        
        this.pg.pixels[x + this.pg.width*y] = c;
      }
    }
    this.pg.updatePixels();
  
    
    this.pg.endDraw();
    image(pg, 0, 0);
  }
  
  float fractalNoise(float x, float y, float z) {
    float r = 0;
    float amp = 1.0;
    for (int octave = 0; octave < 4; octave++) {
      r += noise(x, y, z) * amp;
      amp /= 2;
      x *= 2;
      y *= 2;
      z *= 2;
    }
    return r;
  }

  
  public void setParam1(int v){}
  public void setParam2(int v){}
  public void setParam3(int v){}

}