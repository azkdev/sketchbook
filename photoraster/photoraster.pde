ArrayList<circle> circles;
ArrayList<PVector> spots;
PImage img;
int total, count, attempts;

void setup() {
    size(600, 600);

    circles = new ArrayList<circle>();
    spots = new ArrayList<PVector>();
    
    img = loadImage("manchester.png");
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
    background(0);

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
        if (c.r > .5) c.show();
    }
}

boolean spawnPixel() {
    int idx = int(random(spots.size()));
    PVector r = spots.get(idx);
    float x = r.x * 1;
    float y = r.y * 1;
    
    for (circle c : circles) {
        if (x != c.x && dist(x, y, c.x, c.y) < c.r) {
            spots.remove(idx);
            return false;
        }
    }

    circles.add(new circle(x, y, .1, int(r.z)));
    spots.remove(idx);
    return true;
}