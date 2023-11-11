ArrayList<Triangle> triangles;
int counter = 0;
int currentLevel = 0;
float initialLength;

void setup() {
  size(640, 640);
  triangles = new ArrayList<Triangle>();
  initialLength = width; // The side length of the initial triangle
  // Add the initial large triangle with a starting color
  triangles.add(new Triangle(new PVector(0, height), new PVector(width, height), new PVector(width/2, height - sqrt(3)/2 * width), getColor(initialLength)));
}

void draw() {
  // Adjust the frame rate based on the current level (smaller triangles = faster frame rate)
  frameRate(5 + currentLevel); // Example formula, adjust as needed

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
  // Calculate and add the three smaller triangles with new colors
  PVector mid1 = new PVector((t.a.x + t.b.x) / 2, (t.a.y + t.b.y) / 2);
  PVector mid2 = new PVector((t.b.x + t.c.x) / 2, (t.b.y + t.c.y) / 2);
  PVector mid3 = new PVector((t.c.x + t.a.x) / 2, (t.c.y + t.a.y) / 2);

  float newLength = dist(mid1.x, mid1.y, mid2.x, mid2.y);
  int newColor = getColor(newLength);

  triangles.add(new Triangle(t.a, mid1, mid3, newColor));
  triangles.add(new Triangle(mid1, t.b, mid2, newColor));
  triangles.add(new Triangle(mid3, mid2, t.c, newColor));
}

int getColor(float length) {
  // Map the length to a range of colors
  float hueValue = map(length, 0, 100, 255, 55);
  return color(0, currentLevel, hueValue);
}

class Triangle {
  PVector a, b, c;
  int col; // Color
  
  Triangle(PVector a, PVector b, PVector c, int col) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.col = col;
  }
  
  void display() {
    fill(col);
    noStroke();
    triangle(a.x, a.y, b.x, b.y, c.x, c.y);
  }
}
