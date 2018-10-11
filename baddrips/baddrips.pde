OPC opc;
Drip[] drips = {};
int iteration = 0;
DripRow dr;
DripRow[] rows = {};


void setup()
{
  size(600, 240);
  colorMode(HSB, 100);
  dr = new DripRow(drips, 0);
  rows = (DripRow[]) append(rows, dr);
  opc = new OPC(this, "127.0.0.1", 7890);
  opc.ledGrid(0, 30, 12, width/2, height/2, width/30.0, height/12.0, 0.0, false);
}

class Drip
{
  int xpos, ypos, endpos;
  Drip(int x, int y, int end) {
    xpos = x;
    ypos = y;
    endpos = end;
  }
  
  boolean isNotEnd(int nextx) {
    return nextx*12 < endpos;
  }
  
  void update() {
    if (isNotEnd(xpos)) {
        xpos =  xpos + 1;
    }
    rect(xpos*12, ypos*16, 12, 16);
  }
}

class DripRow {
  Drip[] drips;
  int ypos;
  float rand;
  
  DripRow(Drip[] dripsParam, int y) {
    drips = dripsParam;
    ypos = y;
    rand = random(18) + 6;
  }
  
  void update() { 
    for (int i=0; i<drips.length; i++) {
      drips[i].update();
    }
    if (iteration % int(rand) == 0) {
      drips = (Drip[]) append(drips, new Drip(0, ypos, width - (12* drips.length)));
    }
  }
}

void draw()
{
  background(0);
  fill(50);
  iteration = iteration + 1;
  noStroke();
  for (int k = 0; k < rows.length; k++) {
    rows[k].update();
  }
  
  if(iteration % 11 == 0) {
    rows = (DripRow[]) append(rows, new DripRow(drips, int(random(16))));
  }
}
