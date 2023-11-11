ArrayList<Triangle> triangles;
int frameDelay = 30; // Adjust this value for faster or slower drawing
int counter = 0;
int currentLevel = 0; // Track the current level of iteration

void setup() {
  size(640, 640);
  triangles = new ArrayList<Triangle>();
  // Add the initial large triangle
  triangles.add(new Triangle(new PVector(0, height), new PVector(width, height), new PVector(width/2, height - sqrt(3)/2 * width)));
}

void draw() {
  frameRate(5 + pow(currentLevel, 2)); // Framerate accelerates as triangles get smaller...
  background(255);

  // Draw all triangles
  for (Triangle t : triangles) {
    t.display();
  }

  // Add new triangles at each frame
  if (currentLevel < triangles.size()) {
    addSubTriangles(triangles.get(currentLevel));
    currentLevel++;
  }
}

void addSubTriangles(Triangle t) {
  // Calculate and add the three smaller triangles
  PVector mid1 = new PVector((t.a.x + t.b.x) / 2, (t.a.y + t.b.y) / 2);
  PVector mid2 = new PVector((t.b.x + t.c.x) / 2, (t.b.y + t.c.y) / 2);
  PVector mid3 = new PVector((t.c.x + t.a.x) / 2, (t.c.y + t.a.y) / 2);

  triangles.add(new Triangle(t.a, mid1, mid3));
  triangles.add(new Triangle(mid1, t.b, mid2));
  triangles.add(new Triangle(mid3, mid2, t.c));
}

class Triangle {
  PVector a, b, c;
  
  Triangle(PVector a, PVector b, PVector c) {
    this.a = a;
    this.b = b;
    this.c = c;
  }
  
  void display() {
    triangle(a.x, a.y, b.x, b.y, c.x, c.y);
  }
}
