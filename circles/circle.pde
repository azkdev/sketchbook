class Circle {
  
  float x, y, r;
  boolean growing;
  int c;
  
  Circle(float x, float y) {
    this.x = x;
    this.y = y;
    r = 0;
    //c = color(0, 211, 232);
    c = color(random(255), random(255), random(255));
    growing = true;
  }
  
  void grow() {
    if (growing && r < 10) r += .5;
  }
  
  void show() {
    stroke(c);
    strokeWeight(2);
    noFill();
    ellipse(x, y, r*2, r*2);
  }
  
  boolean isOverflow() {
    return x + r > width || x - r < 0 || y + r > height || y - r < 0;
  }

}