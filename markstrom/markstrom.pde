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

boolean record = false;
int unit = 40;
int windowWidth = 1200;
int windowHeight = 840;
int originX = windowWidth / 2;
int originY = windowHeight / 2;
int vertexCount = 24;
int vertexDim = 8;
Module[] mods;

int[][] coordinates = {
  {originX + 16, originY - 16},
  {originX + 24, originY + 16},
  {originX - 16, originY},
  {originX + 32, originY - 40},
  {originX + 40, originY + 40},
  {originX - 48, originY + 8},
  {originX + 16, originY - 64},
  {originX + 56, originY - 72},
  {originX + 64, originY + 48},
  {originX + 24, originY + 64},
  {originX - 72, originY + 24},
  {originX - 72, originY - 16},
  {originX + 80, originY - 72},
  {originX + 16, originY + 88},
  {originX - 80, originY - 40},
  {originX - 16, originY - 120},
  {originX + 96, originY - 96},
  {originX + 104, originY - 56},
  {originX + 96, originY + 64},
  {originX + 40, originY + 112},
  {originX - 8, originY + 112},
  {originX - 104, originY + 56},
  {originX - 128, originY - 56},
  {originX - 96, originY - 80}
};

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

int polarX(float psi, int radius) {
  return int(radius * cos(psi));
}

int polarY(float psi, int radius) {
  return int(radius * sin(psi));
}

int originDistance(float y, float x) {
  return floor(sqrt(pow((originX - x), 2) + pow((originY - y), 2)));
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
  int unitTmp = 4;
  int psi = 0;
  mods = new Module[vertexCount];
  for (
      int counter = 0;
      counter < vertexCount;
      ++counter, psi += 120
      ) {
    int unitX = coordinates[counter][0];
    int unitY = coordinates[counter][1];
    mods[counter] = new Module(unitTmp, unitTmp, unitX, unitY, radiusRate);
    if (counter % 2 == 0 && counter > 0) {
      psi += 4;
    }
  }

  if (record) {
    setupGif();
  }
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

  if (record) {
    gifAddFrame();
  }
}

class Module {
  int xOffset, yOffset;
  int radius, rate;
  float x, y, psi;
  // Contructor
  Module(int xOffsetTemp, int yOffsetTemp, int xTemp, int yTemp, int rate) {
    this.xOffset = xOffsetTemp;
    this.yOffset = yOffsetTemp;
    this.x = xTemp;
    this.y = yTemp;
    this.psi = atan2(this.y, this.x);
    this.radius = originDistance(this.y, this.x);
    this.rate = rate;
  }
  void update() {
    this.psi += this.rate * this.radius;
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
