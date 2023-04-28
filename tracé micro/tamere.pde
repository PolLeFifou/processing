import processing.sound.*;


float x1 = 700;
float y1 = 400;
//float a1 = 300;
//float b1 = 500;

Amplitude amp;
AudioIn in;
float ampt;

void setup(){
fullScreen();
//size (800,800);
smooth();
background(0);

 amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);

}

void draw(){
  ampt = amp.analyze();
  println(ampt);
  if (ampt>0.030) {

float x2 = x1 + random(-20,20);
float y2 = y1 + random(-20,20);
//float a2 = a1 + random(-20,20);
//float b2 = b1 +random(-20,20);

line(x1,y1,x2,y2);
//line (a1,b1,a2,b2);
stroke (255);

x1 = x2;
y1 = y2;
//a1= a2;
//b1=b2;
  }
  // Constrain all points to the screen
  x1 = constrain(x1, 0, width);
  y1 = constrain(y1, 0, height);
 }
