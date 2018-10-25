public class RotatingRectangleLayer extends Layer {
    private int degrees = 0;
    private float rectWidth = 50;
    private float c = 60;

    public RotatingRectangleLayer(PGraphics pg) {
        super(pg);
    }

    public void draw() {
        this.pg.beginDraw();
        this.pg.background(0);
        colorMode(HSB, 100);
        this.pg.fill(color(c, 100, 100));

        degrees = (degrees + 1) % 360;
        this.pg.translate(width/2, height/2);
        rectWidth = sin(radians(degrees * 3)) * 100;
        this.pg.rotate(radians(degrees));
        this.pg.rect(-(rectWidth/2), -300, rectWidth, 600);

        this.pg.endDraw();
        image(pg, 0, 0);
        colorMode(RGB, 255);
    }

    public void setParam1(float v){
        c = map(v, 0.0, 1.0, 0, 100);
    }
    public void setParam2(float v){
    }
    public void setParam3(float v){}
}
