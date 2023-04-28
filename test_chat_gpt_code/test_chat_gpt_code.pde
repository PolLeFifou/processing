import processing.sound.*;
import ddf.minim.*;

// Initialise l'objet Minim et le lecteur audio
Minim minim;
AudioPlayer player;

// Initialise les paramètres de la sphère
float radius = 200;
int numPoints = 1000;

// Initialise les paramètres de la grille
int numCols = 16;
int numRows = 12;
float cellSize;

// Initialise l'angle de rotation de la sphère
float angleX, angleY;

void setup() {
  // Initialise la fenêtre
  size(800, 600, P3D);

  // Initialise Minim et charge le fichier mp3
  minim = new Minim(this);
  player = minim.loadFile("miss.mp3");

  // Initialise la grille
  cellSize = radius / numCols;
}

void draw() {
  // Efface l'écran à chaque frame
  background(0);

  // Si le lecteur audio n'est pas en pause, met à jour la grille
  if (!player.isPlaying()) {
    player.rewind();
    player.play();
  } else {
    updateGrid();
  }
}

void updateGrid() {
  // Récupère le volume du son en entrée
  float level = player.mix.level();

  // Calcule le rayon de la sphère en fonction du volume
  float r = radius * (1 + level);

  // Dessine la sphère
  pushMatrix();
  translate(width/2, height/2, -r);
  rotateX(angleX);
  rotateY(angleY);
  noStroke();
  for (int i = 0; i < numPoints; i++) {
    // Calcule les coordonnées sphériques du point courant
    float theta = map(i, 0, numPoints-1, 0, TWO_PI);
    float phi = map(sin(theta*5), -1, 1, -HALF_PI, HALF_PI);
    float x = r * cos(theta) * cos(phi);
    float y = r * sin(theta) * cos(phi);
    float z = r * sin(phi);

    // Interpole la couleur en fonction de la position Z
    float zNorm = map(z, -r, r, 0, 1);
    color fromColor = color(255, 255, 255);
    color toColor = color(255, 255, 255);
    color pointColor = lerpColor(fromColor, toColor, zNorm);
    fill(pointColor);

    // Dessine le point courant
    pushMatrix();
    translate(x, y, z);
    sphere(cellSize);
    popMatrix();
  }
  popMatrix();

  // Incrémente l'angle de rotation de la sphère
  angleX += 0.01;
  angleY += 0.02;
}

void stop() {
  // Arrête la lecture du fichier mp3 et libère les ressources de Minim
  player.close();
  minim.stop();
  super.stop();
}
