interface Displayable {
  void display();
}
interface Moveable {
  void move();
}
class Thing {
  float x, y;

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class Rock extends Thing implements Displayable {
  Rock(float x, float y) {
    super(x, y);
  }


  float ran1 = random(20) + 30;
  float ran2 = random(20) + 30;


  void display() {
    image(rock, x, y, 50, 50);
  }
}

public class LivingRock extends Rock implements Moveable {
  float[] eyeColors = new float[] { random(0,255), random(0,255), random(0, 255) };
  int[] xChanges = new int[] { 5, 0, -10, 0 };
  int[] yChanges = new int[] { 0, 5, 0, -10 };

  LivingRock(float x, float y) {
    super(x, y);
  }


   void display() {
      super.display();
      fill(255);
      ellipse(x+10,y+20,20,20);
      ellipse(x+35,y+20,15,15);
      fill(eyeColors[0],eyeColors[1],eyeColors[2]);
      ellipse(x+10,y+20,10,10);
      ellipse(x+35,y+20,10,10);
      fill(0);
      ellipse(x+12,y+20,7,7);
      ellipse(x+33,y+20,7,7);
  }

  float z= random(-10,10);
  float g = random(-10,10);

 void move() {
    if ((x < 950) && (x > 10)){
      x += z;
    }
    if ((y < 740) && (y > 10)){

      y += g;
    }
  }
}

class Ball extends Thing implements Displayable, Moveable {
  Ball(float x, float y) {

    super(x, y);
  }

  float r = random(255);
  float g = random(255);
  float bl = random(255);

  float size = random(30,50);

  void display() {
    noStroke();
    fill(r, g, bl);
    ellipse(x, y, size , size);
  }



  float a = random(-5, 5);
  float b = random(-5, 5);
  int direction=1;

  void move() {
    if ((x < 950) && (x > 0) && (y < 750) && (y > 25)) {
      x += a*direction;
      y += b*direction;
    } else {
      direction*=-1;
      x += a*direction;
      y += b*direction;
    }
  }
}

  class EarthBall extends Thing implements Displayable, Moveable {
    EarthBall(float x, float y) {

      super(x, y);
    }
    void display() {
      noStroke();
      fill(142, 100, 64);
      ellipse(x, y, 50, 50);
    }



    float a = random(-5, 5);
    float b = random(-5, 5);
    int goingdown = 1;
    int time = 1;
    void move() {
      if (!(x < 950) || !(x > 0)) {
        goingdown*=-1;
      }
      if ((y < 750) && (y > 25)) {
        y += a;
      }
      if (goingdown==1) {
        time++;
        x+=0.2;
        y = 1/2*9.81*time*time;

        time++;
        x+=0.2;
        y = 1/2*9.81*time*time;
      }
    }
  }


  ArrayList<Displayable> thingsToDisplay;
  ArrayList<Moveable> thingsToMove;
  PImage rock;


  void setup() {
    size(1000, 800);
    rock=loadImage("rock.png");
    thingsToDisplay = new ArrayList<Displayable>();
    thingsToMove = new ArrayList<Moveable>();
    for (int i = 0; i < 10; i++) {
      Ball b = new Ball(50+random(width-100), 50+random(height)-100);
      thingsToDisplay.add(b);
      thingsToMove.add(b);
      Rock r = new Rock(50+random(width-100), 50+random(height)-100);
      thingsToDisplay.add(r);
    }

    LivingRock m = new LivingRock(50+random(width-100), 50+random(height)-100);
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }

  void draw() {
    background(255);

    for (Displayable thing : thingsToDisplay) {
      thing.display();
    }
    for (Moveable thing : thingsToMove) {
      thing.move();
    }
  }
