import themidibus.*;

OPC opc;
boolean autoPilot = false;
MidiBus myBus;
Integer counter;

HashMap<Integer, Parameter> faders = initFaders();
HashMap<Integer, Parameter[]> knobs = initKnobs();

ArrayList<Layer> layers = new ArrayList();

void setup()
{
  size(120, 300);

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  //// Map an 8x8 grid of LEDs to the center of the window, scaled to take up most of the space
  opc.ledGrid(0, 30, 12, width/2, height/2, height/30.0, width/12.0, -HALF_PI, false);
  
  //// Make the status LED quiet
  opc.setStatusLed(false);
  
  layers.add(new RedLayer(createGraphics(width, height)));
  layers.add(new GreenLayer(createGraphics(width, height)));
  layers.add(new CloudLayer(createGraphics(width, height)));
  layers.add(new RandomLayer(createGraphics(width, height)));
  layers.add(new StrobeLayer(createGraphics(width, height)));
  
  myBus = new MidiBus(this, -1, -1);
  connectToLaunchControl();

}

void draw() {
   background(0, 0);
   if (autoPilot) {
     autoUpdate();
   }
   
   // Order matters! Last one drawn will be on top.
   for (int i = 0; i < layers.size(); i++) {
     Layer l = layers.get(i);
     l.drawWithAlpha(faders.get(i).getValue());
     l.setParam1(knobs.get(i)[0].getValue());
     l.setParam2(knobs.get(i)[1].getValue());
     l.setParam3(knobs.get(i)[2].getValue());
   }
}

void toggleAutoPilot() {
  String[] attached = myBus.attachedInputs();
  if (!autoPilot && attached.length > 0) { // If autoPilot is off and we are connected, turn on
    println("autoPilot on");
    autoPilot = true;
    myBus.sendNoteOn(1, 60, 127);
  } else {
    if (attached.length > 0) {
      myBus.sendNoteOff(1, 60, 127);
    }
    println("autoPilot off");
    autoPilot = false; 
  }
}

void connectToLaunchControl() {
  String[] inputs = myBus.availableInputs();
  println(inputs);
  if (Arrays.asList(inputs).indexOf("Launch Control XL") > -1) {
    autoPilot = false;
    myBus.addInput("Launch Control XL");
    myBus.addOutput("Launch Control XL");
    println(myBus.attachedOutputs());
    myBus.sendNoteOn(1, 60, 100);
    println("Connected to Launch Control XL");
  } else {
    autoPilot = true;
    println("No Launch Control, turning auto pilot on");
  }
}

void noteOn(int channel, int pitch, int velocity) {
   if (pitch == 60) { // Solo Button
    toggleAutoPilot();
  }
}
void controllerChange(ControlChange change) {
  // Receive a controllerChange
  // Faders start at 77 and go up one at a time
  // Knobs start at 1. numbering goes down a column, then over to the right until 24 (three rows of 8 columns)

  int number = change.number();
  if (number >= 77 && number <= 84) { // Faders
    if (autoPilot) {
      return; 
    }
    faders.get(change.number() - 77).setValue(change.value(), 0, 127);  
  } else if (number >= 1 && number <= 24) { // Knobs
    if (autoPilot) {
      return; 
    }
    int column = Math.floorDiv((number - 1), 3);
    int row = (number - 1) % 3;
    knobs.get(column)[row].setValue(change.value(), 0, 127); // Update in place
  }
}

HashMap<Integer, Parameter> initFaders() {
  HashMap<Integer, Parameter> faders = new HashMap();
  faders.put(0, new Parameter(0));
  faders.put(1, new Parameter(0));
  faders.put(2, new Parameter(0));
  faders.put(3, new Parameter(0));
  faders.put(4, new Parameter(0));
  faders.put(5, new Parameter(0));
  faders.put(6, new Parameter(0));
  faders.put(7, new Parameter(0));
  return faders;
}

HashMap<Integer, Parameter[]> initKnobs() {
  HashMap<Integer, Parameter[]> knobs = new HashMap();
  knobs.put(0, new Parameter[]{new Parameter(0), new Parameter(0), new Parameter(0)});
  knobs.put(1, new Parameter[]{new Parameter(0), new Parameter(0), new Parameter(0)});
  knobs.put(2, new Parameter[]{new Parameter(0), new Parameter(0), new Parameter(0)});
  knobs.put(3, new Parameter[]{new Parameter(0), new Parameter(0), new Parameter(0)});
  knobs.put(4, new Parameter[]{new Parameter(0), new Parameter(0), new Parameter(0)});
  knobs.put(5, new Parameter[]{new Parameter(0), new Parameter(0), new Parameter(0)});
  knobs.put(6, new Parameter[]{new Parameter(0), new Parameter(0), new Parameter(0)});
  knobs.put(7, new Parameter[]{new Parameter(0), new Parameter(0), new Parameter(0)});
  return knobs;
}

int currentPattern = 0;
int nextPattern = 1;
void autoUpdate() {
  
  int currentPattern = (Math.floorDiv(millis(), 10000) % layers.size());
  faders = initFaders();
  faders.get(currentPattern).setValue(1.0, 0.0, 1.0);
}
