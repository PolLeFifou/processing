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
  ellipse(x+border, y*ySteps+border, frequency, frequency);
}

  void stop() {
  song.close();
  minim.stop();
  super.stop();
}
