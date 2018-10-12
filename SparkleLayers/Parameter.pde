public class Parameter {
  private float value = 0.0;
  public Parameter(float start) {
    this.value = start;
  }
  
  public void setValue(float x, float min, float max) {
    float b = constrain(x, min, max);
    this.value = map(b, min, max, 0.0, 1.0);
  }
  
  public void increment(float x) {
    float inc = constrain(x, 0.0, 1.0);
    
    if (this.value >= 1.0) { // If max, set to min
      this.value = 0.0;
    }
    this.setValue(this.value + inc, 0.0, 1.0); // increment by 1/1000th of the total
  }
  
  public void increment() {
    this.increment(0.001);
  }
  
  public float getValue() { return this.value; }
}