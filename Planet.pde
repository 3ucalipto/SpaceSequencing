// Updated Planet.pde

class Planet {
  float x, y; 
  float tempxpos, tempypos; 

  int w;
  int h;

  // Tracks the object state
  boolean over;
  float me;
  Planet[] friends;

  float rest_posx;  // Rest position X 
  float rest_posy;  // Rest position Y 

  // Text variables
  int yTesto = 100;

  Planet(float x_, float y_, int w_, int h_, Planet[] others, float id) {
    x = tempxpos = x_;
    y = tempypos = y_;
    rest_posx = x;
    rest_posy = y;
    w = w_;
    h = h_;
    me = id;
    friends = others;
  }

  void update() {
    if (overEvent() && !otherOver()) { 
      over = true;
    } else { 
      over = false;
    }
  }

  // Check if the mouse is over this planet
  boolean overEvent() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }

  // Ensure no other planets are active
  boolean otherOver() {
    for (int i = 0; i < friends.length; i++) {
      if (i != me && friends[i].over) {
        return true;
      }
    }
    return false;
  }

  void display() {
    if (over) {
      fill(0, 255, 0);
    } else {
      noFill();
    }
    stroke(255);
    strokeWeight(3);
    rect(x, y, w, h);
  }

  // Individual planet actions
  void mercury() {
    fill(0, 255, 0);
  }

  void venus() {
    fill(0, 255, 0);
  }

  void earth() {
    fill(0, 255, 0);
  }

  void mars() {
    fill(0, 255, 0);
  }

  void jupiter() {
    fill(0, 255, 0);
  }

  void saturn() {
    fill(0, 255, 0);
  }

  void uranus() {
    fill(0, 255, 0);
  }

  void neptune() {
    fill(0, 255, 0);
  }
}
