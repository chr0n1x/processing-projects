int windowWidth = 800;
int windowHeight = 800;

void setup() {
  frameRate(18);
  size(windowWidth, windowHeight);
}

void draw() {
  background(255);
}

class Brush {
  int x, y;
  float fade, pressure;

  Brush(int xStart, int yStart, float fade, float pressure) {
    this.x = xStart;
    this.y = yStart;
    this.fade = fade;
    this.pressure = pressure;
  }

  void drawPath(int x, int y) {

  }
}

class InkBlot {

}
