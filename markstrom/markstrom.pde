import gifAnimation.*;

// GIF CODE
GifMaker gifExport;
void mousePressed() {
  gifExport.finish();
}
void setupGif() {
  gifExport = new GifMaker(this, "markstrom.gif");
  gifExport.setRepeat(0);
  gifExport.setTransparent(0,0,0);
}
void gifAddFrame() {
  gifExport.setDelay(1);
  gifExport.addFrame();
}

int unit = 40;
int windowWidth = 1200;
int windowHeight = 840;
int vertexCount = 24;
int vertexDim = 8;
Module[] mods;

int[][] mappings = {
  // central K3
  {1, 2},
  {1, 3},
  {2, 3},

  // "spokes" connecting inner K3 to K3s inside cycle
  {1, 4},
  {2, 5},
  {3, 6},
  {4, 7},
  {4, 8},
  {7, 8},
  {5, 9},
  {5, 10},
  {9, 10},
  {6, 11},
  {6, 12},
  {11, 12},

  // "spokes" connecting to outer-most K3s or outer cycle
  {7, 16},
  {8, 13},
  {9, 19},
  {10, 14},
  {11, 22},
  {12, 15},

  // outer K3s
  {13, 17},
  {13, 18},
  {17, 18},
  {14, 20},
  {14, 21},
  {20, 21},
  {15, 23},
  {15, 24},
  {23, 24},

  // final edges to complete outer cycle
  {16, 17},
  {18, 19},
  {19, 20},
  {21, 22},
  {22, 23},
  {24, 16}
};

int polarX(int psi, int radius) {
  return int(radius * cos(psi));
}

int polarY(int psi, int radius) {
  return int(radius * sin(psi));
}

void drawModuleLine(Module one, Module two, int col) {
  stroke(col);
  strokeWeight(1);
  line(one.getX(), one.getY(), two.getX(), two.getY());
}

// set up all vertices / modules
void setup() {
  frameRate(18);
  size(windowWidth, windowHeight);

  // number of vertices in the Markstrom graph
  int radiusRate = 32;
  int radius = windowWidth / vertexCount;
  int unitTmp = unit / 2;
  int psi = 0;
  mods = new Module[vertexCount];
  for (
      int counter = 0;
      counter < vertexCount;
      ++counter, psi += 120
      ) {
    int unitX = polarX(psi, radius) + windowWidth / 2;
    int unitY = polarY(psi, radius) + windowHeight / 2;
    mods[counter] = new Module(unitTmp, unitTmp, unitX, unitY, psi, radius, radiusRate);
    if (counter % 2 == 0 && counter > 0) {
      radius += radiusRate;
      psi += 4;
    }
  }

  setupGif();
}

void draw() {
  background(0);

  for (int i = 0; i < mods.length; i++) {
    mods[i].draw();
  }

  for (int i = 0; i < mappings.length; i++) {
    // simply because I forgot that arrays start @ 0
    int module1 = mappings[i][0] - 1;
    int module2 = mappings[i][1] - 1;
    drawModuleLine(mods[module1], mods[module2], 255);
  }

  gifAddFrame();
}

class Module {
  int xOffset, yOffset;
  int psi, radius, rate;
  float x, y;
  // Contructor
  Module(int xOffsetTemp, int yOffsetTemp, int xTemp, int yTemp, int psi, int radius, int rate) {
    this.xOffset = xOffsetTemp;
    this.yOffset = yOffsetTemp;
    this.x = xTemp;
    this.y = yTemp;
    this.psi = psi;
    this.radius = radius;
    this.rate = rate;
  }
  void update() {
    this.psi += this.rate;
    this.xOffset = polarX(this.psi, this.radius);
    this.yOffset = polarY(this.psi, this.radius);
  }
  float getY() {
    return this.yOffset + this.y;
  }
  float getX() {
    return this.xOffset + this.x;
  }
  // Custom method for drawing the object
  void draw() {
    this.update();
    fill(255);
    ellipse(this.getX(), this.getY(), vertexDim, vertexDim);
  }
}
