import themidibus.*;

OPC opc;
RedLayer r;
GreenLayer g;

HashMap<Integer, Integer> faders = initFaders();
HashMap<Integer, Integer[]> knobs = initKnobs();
void setup()
{
  size(360, 900);

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  //// Map an 8x8 grid of LEDs to the center of the window, scaled to take up most of the space
  opc.ledGrid(0, 30, 12, width/2, height/2, height/30.0, width/12.0, -HALF_PI, false);
  
  //// Make the status LED quiet
  //opc.setStatusLed(false);
  
  PGraphics rl = createGraphics(width, height);
  PGraphics gl = createGraphics(width/2, height/2);
  r = new RedLayer(rl);
  g = new GreenLayer(gl);
  
  MidiBus myBus = new MidiBus(this, "Launch Control XL", -1);

}

void draw() {
   background(0, 0);
   
   r.setParam1(knobs.get(1)[0]);
   
   g.drawWithAlpha(faders.get(0) / 127.0 );
   r.drawWithAlpha(faders.get(1) / 127.0 );
}

void controllerChange(ControlChange change) {
  // Receive a controllerChange
  // Faders start at 77 and go up one at a time
  // Knobs start at 1. numbering goes down a column, then over to the right until 24 (three rows of 8 columns)
  int number = change.number();
  if (number >= 77 && number <= 84) {
    faders.put(change.number() - 77, change.value());  
  } else if (number >= 1 && number <= 24) {
    println(number, change.value());
    int column = Math.floorDiv((number - 1), 3);
    int row = (number - 1) % 3;
    knobs.get(column)[row] = change.value(); // Update in place
  }
}

HashMap<Integer, Integer> initFaders() {
  HashMap<Integer, Integer> faders = new HashMap();
  faders.put(0,0);
  faders.put(1,0);
  faders.put(2,0);
  faders.put(3,0);
  faders.put(4,0);
  faders.put(5,0);
  faders.put(6,0);
  faders.put(7,0);
  return faders;
}

HashMap<Integer, Integer[]> initKnobs() {
  HashMap<Integer, Integer[]> knobs = new HashMap();
  knobs.put(0, new Integer[]{0, 0, 0});
  knobs.put(1, new Integer[]{0, 0, 0});
  knobs.put(2, new Integer[]{0, 0, 0});
  knobs.put(3, new Integer[]{0, 0, 0});
  knobs.put(4, new Integer[]{0, 0, 0});
  knobs.put(5, new Integer[]{0, 0, 0});
  knobs.put(6, new Integer[]{0, 0, 0});
  knobs.put(7, new Integer[]{0, 0, 0});
  return knobs;
}