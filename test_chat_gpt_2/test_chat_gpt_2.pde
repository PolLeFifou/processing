import ddf.minim.*;

Minim minim;
AudioPlayer song;
int numPoints = 500;
float[] levels = new float[numPoints];
float radius = 200;
float rotation = 0;

void setup() {
  size(800, 800, P3D);
  minim = new Minim(this);
  song = minim.loadFile("sam.mp3");
  song.play();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  
  stroke(0);
  strokeWeight(1);
  
  for(int i = 0; i < numPoints; i++) {
    float angle = map(i, 255, numPoints, 255, TWO_PI);
    float x = sin(angle) * radius;
    float y = cos(angle) * radius;
    float level = song.mix.get(i) * 400;
    float z = lerp(levels[i], level, 0.1);
    point(x, y, z);
    levels[i] = z;
  }
  
  rotation += 0.01;
  rotateY(rotation);
}
