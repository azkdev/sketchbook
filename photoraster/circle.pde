class circle {
    
    float x, y, r, rot;
    int c;
    boolean growing;
    PImage img;

    circle(float x, float y, float r, int c) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.c = c;
        growing = true;
    }
    
    circle(float x, float y, float r, PImage img) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.img = img;
        growing = true;
        rot = random(360);
    }

    boolean isOverflow() {
        return x + r > width || x - r < 0 || y + r > height || y - r < 0;
    }

    boolean overlapping(circle c) {
        return dist(x, y, c.x, c.y) - 1 < r + c.r;
    }

    void grow() {
        if (growing) r += 1;
    }

    void show() {
        stroke(c);
        strokeWeight(2);
        noFill();
        //ellipse(x, y, r * 2, r * 2);
        pushMatrix();
        translate(x, y);
        rotate(radians(rot));
        image(img, 0, 0, r * 2, r * 2);
        popMatrix();
    }

}