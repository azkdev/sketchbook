ArrayList<circle> circles;
ArrayList<PVector> spots;
PImage img;
int total, count, attempts;

void setup() {
    size(800, 800);

    circles = new ArrayList<circle>();
    spots = new ArrayList<PVector>();
    
    img = loadImage("logo.png");
    img.loadPixels();

    for (int x = 0; x < img.width; x++) {
        for (int y = 0; y < img.height; y++) {
            int idx = x + y * img.width;
            color c = img.pixels[idx];
            if (c < 0) spots.add(new PVector(x, y, c));
        }
    }
}

void draw() {
    background(255);

    total = 20;
    count = 0;
    attempts = 0;
    
    if (spots.size() > 0)
        while (count < total) {
            if (spawnPixel()) count++;
            attempts++;
            if (attempts > 1000) {
                noLoop();
                println("Image done!");
                break;
            }
        }
    else {
        noLoop();
        println("No more smpots!");
    }
    
    for (circle c : circles) {
        if (c.growing && c.isOverflow()) c.growing = false;
        else for (circle co : circles) {
            if (c != co && c.overlapping(co)) {
                c.growing = false;
                break;
            }
        }
        c.grow();
        if (c.r > 2) c.show();
    }
}

void keyPressed() {
  if (keyCode == 32) {
    saveFrame();
  }
}

boolean spawnPixel() {
    int idx = int(random(spots.size()));
    if (idx == 0) return false;
    PVector r = spots.get(idx);
    float x = r.x * .4;
    float y = r.y * .4;
    
    for (circle c : circles) {
        if (x != c.x && dist(x, y, c.x, c.y) < c.r) {
            spots.remove(idx);
            return false;
        }
    }

    circles.add(new circle(x, y, 2, int(r.z)));
    spots.remove(idx);
    return true;
}