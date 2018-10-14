public class DripsLayer extends Layer {
    private Drip[] drips = {};
    private int iteration = 0;
    private DripRow dr;
    private DripRow[] rows = {};
    private float c = 50;

    public DripsLayer(PGraphics pg) {
        super(pg);
        dr = new DripRow(drips, 0);
        rows = (DripRow[]) append(rows, dr);
    }

    public void draw() {
        this.pg.beginDraw();
        this.pg.background(0,0);
        colorMode(HSB, 100);
        this.pg.fill(color(c,100,100));

        iteration = iteration + 1;
        noStroke();
        for (int k = 0; k < rows.length; k++) {
          rows[k].update();
        }

        if(iteration % 11 == 0) {
          rows = (DripRow[]) append(rows, new DripRow(drips, int(random(16))));
        }

        this.pg.endDraw();
        image(pg, 0, 0);
        colorMode(RGB, 255);
    }

    public void setParam1(float v){}
    public void setParam2(float v){
      c = map(v, 0.0, 1.0, 0, 100);
    }
    public void setParam3(float v){}

    final class Drip
    {
      private int xpos, ypos, endpos;
      public Drip(int x, int y, int end) {
        xpos = x;
        ypos = y;
        endpos = end;
      }

      private boolean isNotEnd(int nextx) {
        return nextx*12 < endpos;
      }

      public void update() {
        if (isNotEnd(xpos)) {
            xpos =  xpos + 1;
        }
        rect(xpos*12, ypos*16, 12, 16);
      }
    }

    final class DripRow {
      private Drip[] drips;
      private int ypos;
      private float rand;

      public DripRow(Drip[] dripsParam, int y) {
        drips = dripsParam;
        ypos = y;
        rand = random(18) + 6;
      }

      public void update() {
        for (int i=0; i<drips.length; i++) {
          drips[i].update();
        }
        if (iteration % int(rand) == 0) {
          drips = (Drip[]) append(drips, new Drip(0, ypos, width - (12* drips.length)));
        }
      }
    }

}
