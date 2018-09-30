OPC opc;
int degrees = 0;
float rectWidth = 50;
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
  degrees = (degrees + 1) % 360;
  translate(width/2, height/2);
  rectWidth = sin(radians(degrees * 3)) * 100;
  rotate(radians(degrees));
  rect(-(rectWidth/2), -300, rectWidth, 600);

}