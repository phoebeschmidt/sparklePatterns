public class ConwayLayer extends Layer {
    // Size of cells
  int cellsize = 10;
  
  // How likely for a cell to be alive at start (in percentage)
  float probabilityOfAliveAtStart = 15;
  
  // Variables for timer
  int interval = 130;
  int lastRecordedTime = 0;
  
  // Colors for active/inactive cells
  color alive = color(0, 200, 0);
  color dead = color(0);
  
  // Array of cells
  int[][] cells; 
  // Buffer to record the state of the cells and use this while changing the others in the interations
  int[][] cellsBuffer; 
  
  // Pause
  boolean pause = false;
  
  int[] history = {0,0,0,0,0,0,0,0,0,0};
  int stepNumber = 0;

  public ConwayLayer(PGraphics pg) {
    super(pg);
    // This stroke will draw the background grid
    pg.stroke(48);
  
    pg.noSmooth();

  }
  
  void start() {
     // Instantiate arrays 
    cells = new int[12][30];
    cellsBuffer = new int[12][30];
  
      
    // Initialization of cells
    for (int x=0; x<12; x++) {
      for (int y=0; y<30; y++) {
        float state = random (100);
        if (state > probabilityOfAliveAtStart) { 
          state = 0;
        }
        else {
          state = 1;
        }
        cells[x][y] = int(state); // Save state of each cell
      }
    }
  }
  
  void draw() {
    if (cells == null) {
      start();
    }
    pg.beginDraw();
    pg.background(0, 0);
    colorMode(HSB, 100);

    //Draw grid
    for (int x=0; x<12; x++) {
      for (int y=0; y<30; y++) {
        if (cells[x][y]>0) {
          pg.fill(color((float(millis()) / 100) % 100, 100, 100)); // If alive
        }
        else {
          pg.fill(color(0, 0, 0)); // If dead
        }
        pg.rect(x * cellsize, y*cellsize, cellsize, cellsize);
      }
    }
    // Iterate if timer ticks
    if (millis()-lastRecordedTime > interval) {
      if (!pause) {
        iteration();
        lastRecordedTime = millis();
      }
    }
  
    //// Create  new cells manually on pause
    if (pause && mousePressed) {
      // Map and avoid out of bound errors
      int xCellOver = int(map(mouseX, 0, pg.width, 0, 12));
      xCellOver = constrain(xCellOver, 0, 12-1);
      int yCellOver = int(map(mouseY, 0, pg.height, 0, 30));
      yCellOver = constrain(yCellOver, 0, 30-1);
  
      // Check against cells in buffer
      if (cellsBuffer[xCellOver][yCellOver]==1) { // Cell is alive
        cells[xCellOver][yCellOver]=0; // Kill
        pg.fill(dead); // pg.fill with kill color
      }
      else { // Cell is dead
        cells[xCellOver][yCellOver]=1; // Make alive
        pg.fill(alive); // pg.fill alive color
      }
    } 
    else if (pause && !mousePressed) { // And then save to buffer once mouse goes up
      // Save cells to buffer (so we opeate with one array keeping the other intact)
      for (int x=0; x<12; x++) {
        for (int y=0; y<30; y++) {
          cellsBuffer[x][y] = cells[x][y];
        }
      }
    }
    pg.endDraw();
    image(pg, 0,0);
    colorMode(RGB, 255);

  }



  void iteration() { // When the clock ticks
    // Save cells to buffer (so we opeate with one array keeping the other intact)
    //print("iteration\n");
    int counter = 0;
    for (int[] row: cells) {
      for (int cell: row) {
        if (cell >0 ) {
          counter += 1;
        }
      }
    }
    boolean shouldClear = true;
    for (int h : history) {
      if (h != counter) {
        shouldClear = false;
      }
    }
    if (shouldClear || stepNumber % 100 == 99) {
      clear();
      start();
      for (int i = 0; i < history.length; i++) {
        history[i] = 0;
      }
      stepNumber = 0;
    } else {
      history[stepNumber % 10] = counter;
      stepNumber += 1; 
    }
    
    
    for (int x=0; x<12; x++) {
      for (int y=0; y<30; y++) {
        cellsBuffer[x][y] = cells[x][y];
      }
    }
  
    // Visit each cell:
    for (int x=0; x<12; x++) {
      for (int y=0; y<30; y++) {
        // And visit all the neighbours of each cell
        int neighbours = 0; // We'll count the neighbours
        for (int xx=x-1; xx<=x+1;xx++) {
          for (int yy=y-1; yy<=y+1;yy++) {  
            if (((xx>=0)&&(xx<12))&&((yy>=0)&&(yy<30))) { // Make sure you are not out of bounds
              if (!((xx==x)&&(yy==y))) { // Make sure to to check against self
                if (cellsBuffer[xx][yy]==1){
                  neighbours ++; // Check alive neighbours and count them
                }
              } // End of if
            } // End of if
          } // End of yy loop
        } //End of xx loop
        // We've checked the neigbours: apply rules!
        if (cellsBuffer[x][y]==1) { // The cell is alive: kill it if necessary
          if (neighbours < 2 || neighbours > 3) {
            cells[x][y] = 0; // Die unless it has 2 or 3 neighbours
          }
        } 
        else { // The cell is dead: make it live if necessary      
          if (neighbours == 3 ) {
            cells[x][y] = 1; // Only if it has 3 neighbours
          }
        } // End of if
      } // End of y loop
    } // End of x loop
  } // End of function

  void keyPressed() {
    if (key=='r' || key == 'R') {
      // Restart: reinitialization of cells
      for (int x=0; x<12; x++) {
        for (int y=0; y<30; y++) {
          float state = random (100);
          if (state > probabilityOfAliveAtStart) {
            state = 0;
          }
          else {
            state = 1;
          }
          cells[x][y] = int(state); // Save state of each cell
        }
      }
    }
    if (key==' ') { // On/off of pause
      pause = !pause;
    }
    if (key=='c' || key == 'C') { // Clear all
    }
  } 
  
  void clear() {
    for (int x=0; x<12; x++) {
      for (int y=0; y<30; y++) {
        cells[x][y] = 0; // Save all to zero
      }
    }
  }
  public void setParam1(float v) {
    return;
  }
  public void setParam2(float v) {
    return;
  }
  public void setParam3(float v) {
    return;
  }

}