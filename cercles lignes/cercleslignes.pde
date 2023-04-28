import ddf.minim.*;

Minim minim;
AudioPlayer song;

int spacing = 16; // space between lines in pixels
int border = spacing*2; // top, left, right, bottom border
int amplification = 3; // frequency amplification factor
int y = spacing;
float ySteps; // number of lines in y direction

void setup() {
  size(800, 800);
  background(255);
  strokeWeight(1);
  stroke(0);
  noFill();
  minim = new Minim(this);
  song = minim.loadFile("pipi.mp3");
  song.play();
}

void draw() {
  int screenSize = int((width-2*border)*(height-1.5*border)/spacing);
  int x = int(map(song.position(), 0, song.length(), 0, screenSize));
  ySteps = x/(width-2*border); // calculate amount of lines
  x -= (width-2*border)*ySteps; // set new x position for each line
  float frequency = song.mix.get(int(x))*spacing*amplification;

  float amplitude = song.mix.level();
  noStroke();
  fill(0, amplitude*155);
  ellipse(x+border, y*ySteps+border, frequency, frequency); //mettre les formes pleines (enlever ca met juste les tracés)

  float freqMix = song.mix.get(int(x));
  float freqLeft = song.left.get(int(x));
  float freqRight = song.right.get(int(x));
  float size = freqMix * spacing * amplification;
  float red = map(freqLeft, -1, 1, 0, 200);
  float green = map(freqRight, -1, 1, 0, 215);
  float blue = map(freqMix, -1, 1, 0, 55);
  float opacity = map(amplitude, 0, 0.4, 20, 100);

  noStroke();
  fill(red, green, blue, opacity);
  ellipse(x+border, y*ySteps+border, size, size); //mettre de la couleur sur les cercles
  
  if (amplitude < 0.1) {
 noStroke();
 } else {
 stroke(red, green, blue);
 }
 fill(red, blue, green, 15);
 pushMatrix();
 translate(x+border, y*ySteps+border);
 int circleResolution = (int)map(amplitude, 0, 0.6, 3, 8); // number of vertexes
 float radius = size/2;
 float angle = TWO_PI/circleResolution;
 beginShape();
 for (int i=0; i<=circleResolution; i++) {
 float xShape = 0 + cos(angle*i) * radius;
 float yShape = 0 + sin(angle*i) * radius;
 vertex(xShape, yShape);
 }
 endShape();
 popMatrix(); //met d'autres formes que des cercles

strokeWeight(amplitude*5);
 stroke(0,opacity);
 line(x+border, y*ySteps+border-freqMix*spacing, x+border, y*ySteps+border+freqMix*spacing);
 if (amplitude > 0.3) {
 noStroke();
 fill(red, green, blue, 50);
 pushMatrix();
 translate(x+border, y*ySteps+border+size);
 beginShape();
 for (int i=0; i<=circleResolution; i++) {
 float xShape = 0 + cos(angle*i) * radius;
 float yShape = 0 + sin(angle*i) * radius;
 vertex(xShape, yShape);
 }
 endShape();
 popMatrix(); //ajoute d'autres formes un peu en bordel
 }
}


void stop() {
  song.close();
  minim.stop();
  super.stop();
}
