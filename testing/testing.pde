/**
 * Testing Arch linux setup
 * Example from:
 *     http://funprogramming.org/5-Light-speed-effect-change-line-colors.html
 */

void setup() {
  background(0);
}

void draw() {
  stroke(0, random(255), 0);

  line(50, 50, random(100), random(100));
}
