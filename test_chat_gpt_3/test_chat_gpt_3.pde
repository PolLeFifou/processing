import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

float[] bands;
int numPoints = 200;
float[] pointX = new float[numPoints];
float[] pointY = new float[numPoints];
float[] pointZ = new float[numPoints];
float[] pointSpeed = new float[numPoints];

void setup() {
  size(800, 600, P3D);
  smooth(8);
  
  minim = new Minim(this);
  player = minim.loadFile("I guess.mp3");
  player.play();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  bands = new float[fft.specSize()];
  
  for (int i = 0; i < numPoints; i++) {
    pointX[i] = random(-width/2, width/2);
    pointY[i] = random(-height/2, height/2);
    pointZ[i] = random(-500, 500);
    pointSpeed[i] = random(1, 3);
  }
}

void draw() {
  background(0);
  fft.forward(player.mix);
  
  for (int i = 0; i < numPoints; i++) {
    float x = map(pointX[i], -width/2, width/2, 0, width);
    float y = map(pointY[i], -height/2, height/2, 0, height);
    float z = pointZ[i];
    
    int bandIndex = (int) map(i, 0, numPoints, 0, fft.specSize() - 1);
    float bandValue = fft.getBand(bandIndex);
    float radius = map(bandValue, 0, 255, 0, 100);
    
    pushMatrix();
    translate(x, y, z);
    noStroke();
    fill(255);
    ellipse(0, 0, radius, radius);
    popMatrix();
    
    pointZ[i] += pointSpeed[i];
    if (pointZ[i] > 500) {
      pointZ[i] = -500;
    }
  }
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
