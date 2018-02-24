ArrayList<circle> circles;

void setup() {
    size(600, 600);

    circles = new ArrayList<circle>();
    for (int i = 0; i < 10; ++i) {
        circles.add(new circle(random(width), random(height), 0, color(random(255), random(255), random(255))));
    }
}

void draw() {
    background(51);
    for (circle c : circles) {
        if (c.growing && c.isOverflow()) c.growing = false;
        else for (circle co : circles) {
            if (c != co && c.overlapping(co)) {
                c.growing = false;
                break;
            }
        }
        c.grow();
        c.show();
    }
}