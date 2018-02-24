ArrayList<Circle> circles;
JSONArray cities;
int total;
int count;
int attempts;

void setup() {
  size(1440, 720);
  frameRate(60);
  circles = new ArrayList<Circle>();
  cities = loadJSONArray("city.list.min.json");
}

void draw() {
  background(0);
  
  total = 20;
  count = 0;
  attempts = 0;
  
  while (count < total) {
    if (generateCircle()) {
      count += 1;
    }
    attempts += 1;
    if (attempts > 1000) {
      noLoop();
      println("World Done!");
      break;
    }
  }
  
  for (Circle c: circles) {
    if (c.growing && c.isOverflow()) c.growing = false;
    else for (Circle co: circles) {
      if (c != co && circlesOverlapping(c, co)) {
        c.growing = false;
        break;
      } 
    }
    c.grow();
    if (c.r > 1) c.show();
  }
}

boolean generateCircle() {
  println(cities.size());
  int idx = int(random(0, cities.size()));
  JSONObject city = cities.getJSONObject(idx).getJSONObject("coord");
  float x = city.getFloat("lon") * 4 + width * .5;
  float y = city.getFloat("lat") * -4 + height * .5;
  for (Circle c: circles) {
    if (x != c.x && y != c.y) {
      float d = dist(x, y, c.x, c.y);
      if (d < c.r) {
        cities.remove(idx);
        return false;
      }
    }
  }
  circles.add(new Circle(x, y));
  cities.remove(idx);
  return true;
}

boolean circlesOverlapping(Circle c1, Circle c2) {
  return dist(c1.x, c1.y, c2.x, c2.y) - 2 < c1.r + c2.r;
}