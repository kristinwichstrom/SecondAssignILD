import controlP5.*;
import processing.video.*;
ControlP5 cp5;

Movie mov;

//var for background color
int myColor = color(255);
int c1, c2, size;
float n, n1;

//var for slide positions
int yPos = 60;
int xPos = 40;

boolean lines = false;
boolean circle = false;
boolean waves = false;
boolean video1 = true;
boolean video2 = false;
String pathVid1 = "/Users/kristinwichstrom/Desktop/slow_rod4_1080p.mov";


//var for waves
float a = 0;
float s = TWO_PI/100;
int sizeVideos ;

void setup() {
  size(800, 1200);
  smooth();
  noStroke();
  noiseDetail(10);
  cp5 = new ControlP5(this);
  mov = new Movie(this, pathVid1 );


  //COLOR WHEEL
  cp5.addColorWheel("c", xPos*9+30, yPos+40, 120).setRGB(color(255, 255, 255));

  //BACKGROUND COLORS

  cp5.addButton("black")
    .setValue(0)
    .setPosition(xPos, yPos)
    .setSize(70, 70)
    ;

  cp5.addButton("grey")
    .setValue(100)
    .setPosition(xPos, yPos*2.5)
    .setSize(70, 70)
    ;

  cp5.addButton("yellow")
    .setPosition(140, yPos)
    .setValue(0)
    .setSize(70, 70)
    ;

  cp5.addButton("Red")
    .setPosition(140, yPos*2.5)
    .setValue(0)
    .setSize(70, 70)
    ;

  //GRAPHIC CONTROLS
  cp5.addSlider("size")
    .setPosition(xPos*7, yPos)
    .setSize(230, 20)
    .setRange(0, 800)
    .setValue(0)
    ;

  cp5.addToggle("lines")
    .setPosition(xPos*7, yPos+40)
    .setSize(80, 20)
    .setMode(Toggle.SWITCH)
    ;

  cp5.addToggle("circle")
    .setPosition(xPos*7, yPos+80)
    .setSize(80, 20)
    .setMode(Toggle.SWITCH)
    ;

  cp5.addToggle("waves")
    .setPosition(xPos*7, yPos+120)
    .setSize(80, 20)
    .setMode(Toggle.SWITCH)
    ;


  //VIDEOS

  cp5.addSlider("size_videos")
    .setPosition(xPos*15, yPos)
    .setSize(130, 20)
    .setRange(0, width-200)
    .setValue(0)
    ;
  cp5.addToggle("video1")
    .setPosition(xPos*15, yPos+40)
    .setSize(60, 20)
    .setMode(Toggle.SWITCH)
    ;

  cp5.addToggle("video2")
    .setPosition(xPos*15, yPos+80)
    .setSize(60, 20)
    .setMode(Toggle.SWITCH)
    ;
  cp5.addToggle("video4")
    .setPosition(xPos*17, yPos+40)
    .setSize(60, 20)
    .setMode(Toggle.SWITCH)
    ;
  cp5.addToggle("video5")
    .setPosition(xPos*17, yPos+80)
    .setSize(60, 20)
    .setMode(Toggle.SWITCH)
    ;
}

void draw() {
  background(myColor);
  myColor = lerpColor(c1, c2, n);
  drawCirc (c);
  drawLines (c);
  movieSet (mov);
  doWaves(c);
  a+=s;
}

// Background color
public void black(int theValue) {
  println("a button event from colorA: "+theValue);
  c1 = c2;
  c2 = color(0, 0, 0);
}

public void grey(int theValue) {
  println("a button event from colorB: "+theValue);
  c1 = c2;
  c2 = color(#AFAFAF);
}


public void yellow(int theValue) {
  println("a button event from colorC: "+theValue);
  c1 = c2;
  c2 = color(#FFBF1A);
}

public void Red(int theValue) {
  println("a button event from colorC: "+theValue);
  c1 = c2;
  c2 = color(150, 0, 0);
}

int c = color(100);
int size_videos = 100;

// Function Circle
public void drawCirc (int c) {
  noStroke();
  fill (c);
  if (circle) {
    circle(mouseX, mouseY+40, size);
  }
}
// Function lines
public void drawLines (int c) {
  pushMatrix();

  if (lines) {
    translate(400, 400);
    for (int i=0; i<50; i++) {
      pushMatrix();
      fill(c);
      translate(0, i*10);
      rotate(map(size+i, mouseY, 300, -PI, PI));
      rect(-150, 0, size, 2);
      popMatrix();
    }
  }
  popMatrix();
}
// Function movie
void movieSet (Movie m) {
  if (video1) {
    frameRate(30);
    image(m, width/8, height/3, size_videos, size_videos);
    m.play();
  }

  m.read();
}

// Function waves
void doWaves(int c) {

  if (waves) {
    for (float j=width/2; j<height; j+=20) {
      for (int i=50; i<width-80; i++) {
        if (j!=50 && j!=440) { //grid
          float step = sin(a)*(sin((mouseY-i)*PI/400.0));
          float swing = j+step*(180.0*noise(a+i/300.0, a+j/250.0, a/10.0));
          float dx = randomC()/2;
          float dy = randomC()/2;
          float x = i+dx;
          float y = swing+dy;
          fill(c, 200-150*sqrt(sq(dx)+sq(dy))); // noise effect for lines
          ellipse(x, y, 2, 2); // width of stroke
        }
      }
    }
  }
}

float randomC() {
  float r = random(0, 1);
  float ang = sin(TWO_PI*random(0, 3));
  return r*ang;
}
