// Updated Array_of_sphere.pde

import processing.sound.*;

Sphere[] spheres = new Sphere[50];
Planet[] planets = new Planet[8];

float r;
int totalSpheres = 0;
int numPlanet = 8;

int xPlan = 330;

boolean green = false;

// Sound files
SoundFile[][] soundSets = new SoundFile[6][8]; // Updated for 6 sound sets
int currentSet = 0;

// Font variables
PFont b; // bold
PFont reg; // regular
PFont t; // thin
int yTesto = 100;

// Button positions
int ybuttonpos = -100;
boolean[] buttonOver = new boolean[6];
int[] circleY = {350, 420, 490, 560, 630, 700};
int circleSize = 20;
int circleX = 1380;
int selectedButton = 0; // Default to the first sound set (Set 1)

void setup() {
  fullScreen();
  r = 0;

  // Initialize planets
  for (int i = 0; i < numPlanet; i++) {
    planets[i] = new Planet(xPlan + (i * 100), height / 2, 80, 80, planets, i);
  }

  // Load sound files for all sets
  String[][] soundPaths = {
    {
      "Clap [ zip ].wav", "DMV3_Vox 7.wav", "Funky Cm7 [c ebm g bbm].wav",
      "Hi Hat [ zone ].wav", "Open Hat [ lazer ].wav", "Pad Stab.wav",
      "Pray Riser.wav", "The Champion Snare 01.wav"
    },
    {
      "8 bit crash.wav", "808 [ wolf ].wav", "BASE ARKANTO NUEVA PARA PASO CALLE.wav",
      "FXs_08-06.wav", "FXs_09-07.wav", "revive_sax-riff-77_horns-and-reeds_one_shot_.wav",
      "Stick [ zip ].wav", "Sweep Fm7.wav"
    },
    {
      "16A_R_CUP1.wav", "HH_THIN.wav", "HIP_S_SN.wav",
      "L_TOM15_1.wav", "M_TOM12C_1.wav", "MIX_CHH_30TA.wav",
      "MIX_LHH_30TA.wav", "SCRATCH_3.wav"
    },
    {
      "808.wav", "FXs_05-03.wav", "Hi Hat [ hydro ].wav",
      "Krs_FX_4.wav", "Oshi_Guitar_1.wav", "Snare [ flip ].wav",
      "The Champion Snare 02.wav", "The Champion Snare 01.wav"
    },
    {
      "bongo.wav", "BWB PRO PERC  (27).wav", "Krs_BaileFunk_1.wav",
      "Krs_Clap_3.wav", "Krs_Cymbol.wav", "Krs_HiHatLoop_2.wav",
      "MadBliss_Snare_5.wav", "Medasin_Perc_1.wav"
    },
    {
      "TOM2_IND.wav", "SYNTH_KICK.wav", "SYN_GUN.wav",
      "STACK_CYM.wav", "SD30.wav", "RIM_HEV.wav",
      "RIDE_SA.wav", "PL_RIDE.wav"
    }
  };

for (int s = 0; s < soundSets.length; s++) {
  for (int i = 0; i < soundSets[s].length; i++) {
    if (soundSets[s][i] == null) {
      println("Failed to load sound file for set " + s + ", index " + i);
    }
  }
}


  for (int s = 0; s < soundSets.length; s++) {
    for (int i = 0; i < soundSets[s].length; i++) {
      soundSets[s][i] = new SoundFile(this, soundPaths[s][i]);
    }
  }

  // Create fonts
  b = createFont("SuisseIntlMono-Bold", 12);
  reg = createFont("SuisseIntlMono-Regular", 11);
  t = createFont("SuisseIntlMono-Thin", 11);
}

void draw() {
  noStroke();
  fill(0, 100);
  rect(0, 0, width, height);
  buttonUpdate(mouseX, mouseY);

  // Background grid
  pushMatrix();
  translate(mouseX * 0.01, mouseY * 0.01);
  for (int i = 0; i < width + 50; i += 80) {
    for (int j = -30; j < height + 50; j += 80) {
      stroke(90);
      strokeWeight(3);
      point(i, j);
    }
  }
  popMatrix();

  // Left information panel
  fill(240);
  textAlign(LEFT);
  strokeWeight(3);
  String[] planetNames = {"Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"};
  String[] planetInfo = {
    "Gravity:3.7 m/s²\nMass:3.3011×10^23 kg",
    "Gravity:8.87 m/s²\nMass:4.8675×10^24 kg",
    "Gravity:9.807 m/s²\nMass:5.97237×10^24 kg",
    "Gravity:3.711 m/s²\nMass:6.4171×10^23 kg",
    "Gravity:24.79 m/s²\nMass:1.8982×10^27 kg",
    "Gravity:10.44 m/s²\nMass:5.6834×10^26 kg",
    "Gravity:8.87 m/s²\nMass:8.6810×10^25 kg",
    "Gravity:11.15 m/s²\nMass:1.0243×10^26 kg"
  };

  for (int i = 0; i < numPlanet; i++) {
    if (planets[i].over) {
      fill(0, 255, 0); // Highlight in green
    } else {
      fill(240); // Default color
    }
    textFont(b);
    text(planetNames[i], 20, 50 + yTesto + (i * 70));
    textFont(reg);
    text(planetInfo[i], 20, 70 + yTesto + (i * 70));
  }

  // Top text
  textAlign(CENTER);
  fill(255);
  textFont(b);
  text("SPACE SEQUENCING", width / 2, 200);

  // Bottom text (instructions)
  textFont(reg);
  String instruction = "Click and hold to create a circle. Release to make it bounce based on the gravity of each planet. Each planet produces a unique sound. Press any key to reset.";
  text(instruction, width / 2 - 180, height - 160, 380, 100);

 // Right text for sound sets
textAlign(RIGHT);
textFont(b);
fill(255);
text("Change sound sets here", width - 40, 200);
for (int i = 0; i < 6; i++) { // Updated to 6 sound sets
  if (overButton(circleX, circleY[i] + ybuttonpos, circleSize)) {
    fill(0, 255, 0); // Highlight in green when hovered
  } else if (i == selectedButton) {
    fill(0, 255, 0); // Fill selected button in green
  } else {
    fill(0,0,0); // Default white for other buttons
  }
  ellipse(circleX, circleY[i] + ybuttonpos, circleSize, circleSize);
  fill(255); // Reset fill for text
  textFont(reg);
  text("Set 0" + (i + 1), width - 40, circleY[i] + ybuttonpos);
}

  // Date
  int d = day();
  int m = month();
  int y = year();
  textAlign(CENTER);
  text(d + "-" + m + "-" + y, width / 2, 50);

  // Clock
  int sec = second();
  int mins = minute();
  int hr = hour();
  String time = String.format("%02d:%02d:%02d", hr, mins, sec);
  text(time, width / 2, 70);

  // Display planets
  for (Planet planet : planets) {
    pushMatrix();
    translate(mouseX * 0.01, mouseY * 0.01);
    planet.update();
    planet.display();
    popMatrix();
  }

  // Display spheres
  for (int i = 0; i < totalSpheres; i++) {
    pushMatrix();
    translate(mouseX * 0.01, mouseY * 0.01);
    spheres[i].display();
    spheres[i].bounce(currentSet); // Pass the current sound set
    popMatrix();
  }

  // Growing radius on mouse press
  if (mousePressed && mouseY < height / 2 && mouseY > 200 && mouseX > xPlan && mouseX < width - xPlan) {
    noFill();
    ellipse(mouseX, mouseY, r, r);
    r = constrain(r + 1, 0, 60);
  }
}

void mouseReleased() {
  // Check if a sound set button was clicked
  for (int i = 0; i < 6; i++) { // Updated to 6 sound sets
    if (overButton(circleX, circleY[i] + ybuttonpos, circleSize)) {
      selectedButton = i; // Update the selected button
      currentSet = i; // Change sound set
      println("Switched to Sound Set 0" + (i + 1));
      break;
    }
  }

  if (mouseY < height / 2 && mouseY > 200 && mouseX > xPlan && mouseX < width - xPlan) {
    if (totalSpheres < spheres.length) {
      spheres[totalSpheres++] = new Sphere(mouseX, mouseY, r, r);
    }
    r = 0;
  }
}

void buttonUpdate(float x, float y) {
  for (int i = 0; i < buttonOver.length; i++) {
    buttonOver[i] = overButton(circleX, circleY[i] + ybuttonpos, circleSize);
  }

  noFill();
  stroke(255);
  for (int i = 0; i < circleY.length; i++) {
    ellipse(circleX, circleY[i] + ybuttonpos, circleSize, circleSize);
  }
}

boolean overButton(int x, int y, int diameter) {
  return dist(x, y, mouseX, mouseY) < diameter / 2;
}

void keyPressed() {
  reset();
}

void reset() {
  totalSpheres = 0;

  // Stop all sounds in all sound sets
  for (int s = 0; s < soundSets.length; s++) {
    for (int i = 0; i < soundSets[s].length; i++) {
      if (soundSets[s][i].isPlaying()) {
        soundSets[s][i].stop();
      }
    }
  }
}
