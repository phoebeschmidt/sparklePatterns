OPC opc;
RedLayer r;
GreenLayer g;
void setup()
{
  size(360, 900);

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  //opc = new OPC(this, "127.0.0.1", 7890);

  //// Map an 8x8 grid of LEDs to the center of the window, scaled to take up most of the space
  //opc.ledGrid(0, 30, 12, width/2, height/2, height/30.0, width/12.0, -HALF_PI, false);
  
  //// Make the status LED quiet
  //opc.setStatusLed(false);
  
  PGraphics rl = createGraphics(width, height);
  PGraphics gl = createGraphics(width/2, height/2);
  r = new RedLayer(rl);
  g = new GreenLayer(gl);
  
}

void draw() {
   background(0, 0);
   g.drawWithAlpha(.5);
   r.drawWithAlpha(1.0);
}