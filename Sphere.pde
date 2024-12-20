class Sphere {
  float x;
  float y;
  float r;

  float Yspeed;
  float acceleration;

  Sphere(float tempX, float tempY, float tempR, float g) {
    x = tempX;
    y = tempY;
    r = tempR;
    acceleration = g / 40;
    Yspeed = 1;
  }

  void display() {
    stroke(255);
    strokeWeight(2);
    fill(255);
    ellipse(x, y, r, r);
  }

  void bounce(int currentSet) {
    y += Yspeed + acceleration / 2;
    Yspeed += acceleration;

    if (y > (height / 2 - (r / 2))) {
      Yspeed *= -0.99;
      y = height / 2 - (r / 2);
    }

    checkPlanetCollision(currentSet);
  }

  void checkPlanetCollision(int currentSet) {
    for (int i = 0; i < 8; i++) {
      float planetXStart = xPlan + (i * 100);
      float planetXEnd = planetXStart + 100;

      if (y > (height / 2 - (r / 2) - 1) && (x > planetXStart && x < planetXEnd)) {
        soundSets[currentSet][i].play();
        soundSets[currentSet][i].rate(r / 10);
        soundSets[currentSet][i].pan(map(i, 0, 7, -1, 1));
        acceleration = getPlanetGravity(i);
        break;
      }
    }
  }

  float getPlanetGravity(int planetIndex) {
    switch (planetIndex) {
      case 0: return 0.37;   // Mercury
      case 1: return 0.887;  // Venus
      case 2: return 0.980;  // Earth
      case 3: return 0.371;  // Mars
      case 4: return 2.479;  // Jupiter
      case 5: return 1.044;  // Saturn
      case 6: return 0.887;  // Uranus
      case 7: return 1.115;  // Neptune
      default: return 0.0;
    }
  }
}
