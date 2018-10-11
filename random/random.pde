OPC opc;
int degrees = 0;
float rectWidth = 0;
float rectHeight = 0;
float x = 0;
float y = 0;
float skipMod = 0;
float skipModMax = 5; //TODO this maps to a fader
float i = 0;

void setup()
{
  size(600, 240);

  opc = new OPC(this, "127.0.0.1", 7890);
   opc.ledGrid(0, 30, 12, width/2, height/2, width/30.0, height/12.0, 0.0, false);
}

void draw()
{
  background(0);
  fill(100);
  if (i % skipMod > (skipModMax/2)) {
    degrees = (degrees + 1) % 360;
    rectWidth = random(5);
    rectHeight = random(4);
    x = random(width);
    y = random(height);
    rect(x, y, rectWidth * 12, rectHeight * 30);
  }
  skipMod = random(5);
  i = i+1;
}
