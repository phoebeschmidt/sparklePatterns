OPC opc;
int i = 0;
int imod = 40;
int imodLimit = 20; //todo map this to fader
void setup() {
  size(640, 240);
  background(0);
  opc = new OPC(this, "127.0.0.1", 7890);
  opc.ledGrid(0, 30, 12, width/2, height/2, width/30.0, height/12.0, 0.0, false);
}

void draw() { 
  if (i % imod < imodLimit) {
    fill(100);
    rect(0, 0, width, height);
  } else {
    fill(0);
    rect(0, 0, width, height);
  }
  i = i + 1;
}
