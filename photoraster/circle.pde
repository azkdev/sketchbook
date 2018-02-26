class circle {
    
    float x, y, r;
    int c;
    boolean growing;

    circle(float x, float y, float r, int c) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.c = c;
        growing = true;
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
        ellipse(x, y, r * 2, r * 2);
    }

}