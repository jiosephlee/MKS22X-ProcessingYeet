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

class Rock extends Thing implements Displayable{

  PImage rock;
  Rock(float x, float y) {
    super(x, y);
    int n = (int)random(2);
    if (n==1) rock = loadImage("rock.png");
    else rock = loadImage("rock1.png");
  }


  float ran1 = random(20) + 30;
  float ran2 = random(20) + 30;


  void display() {
    //image(rock, x, y, 50, 50);
    ellipse(x, y, 50, 50);
  }

  boolean isTouching(Thing other) {
    if (other.x <= (this.x + 25) && other.x >= (this.x - 25) 
      && other.y <= (this.y + 25) && other.y >= (this.y - 25)) {
      return true;
    }
    return false;
  }
}

public class LivingRock extends Rock implements Moveable {
  float[] eyeColors = new float[] { random(0, 255), random(0, 255), random(0, 255) };
  int[] xChanges = new int[] { 5, 0, -10, 0 };
  int[] yChanges = new int[] { 0, 5, 0, -10 };

  LivingRock(float x, float y) {
    super(x, y);
  }

  void display() {
    super.display();
    fill(255);
    ellipse(x+10, y+20, 20, 20);
    ellipse(x+35, y+20, 15, 15);
    fill(eyeColors[0], eyeColors[1], eyeColors[2]);
    ellipse(x+10, y+20, 10, 10);
    ellipse(x+35, y+20, 10, 10);
    fill(0);
    ellipse(x+12, y+20, 7, 7);
    ellipse(x+33, y+20, 7, 7);
  }

  float z= random(0, 10);
  float g = random(0, 10);

  void move() {
    /*if ((x < 950) && (x > 10)){
     x += z;
     }
     if ((y < 740) && (y > 10)){
     
     y += g;
     }*/
    if ((x < 950) && (x > 10)) {
      if (mouseX > x) {
        x += z;
      } else {
        x -= z;
      }
    }
    if ((y < 740) && (y > 10)) {
      if (mouseY > y) {
        y += z;
      } else {
        y -= z;
      }
    }
    //if touching thing should go here for collisions but I don't know which other thing to use?
  }
}

class Ball extends Thing implements Displayable, Moveable {
  int velocity,dirx,diry;
  float vx,vy;
  
  Ball(float x, float y) {
    super(x, y);
    velocity = (int)random(4) + 2;
    vx = random(velocity-1)+1;
    vy = velocity*velocity - (vx*vx);
    if(random(1) < 0.5){
      dirx = 1;
    } else{
      dirx = -1;
    }
    if(random(1) < 0.5){
      diry = 1;
    } else{
      diry = -1;
    }
    System.out.println("vx :" + vx);
    System.out.println("vy:" + vy);
    System.out.println("dirx, diry" + dirx + "," + diry);
  }

  float r = random(255);
  float g = random(255);
  float bl = random(255);

  float size = random(30, 50);

  void display() {
    noStroke();
    fill(r, g, bl);
    ellipse(x, y, size, size);
  }

  void move() {
    if((x > 970) || (x < 20)){
      dirx*=-1;
      x += vx * dirx;
      y += vy * diry;
    } else if ((y > 770) || (y < 30)) {
      diry*=-1;
      x += vx * dirx;
      y += vy * diry;
    } else{
      x += vx * dirx;
      y += vy * diry;
    }
  }
}

class BBall extends Ball implements Displayable, Moveable {

  BBall (float x, float y) {
    super(x, y);
  }
  
  PImage google = loadImage("ball.png");
  
  void display() {
    image(google, x,y,50,50);
  }

  void move() {
    super.move();
  }
  
}

class EarthBall extends Ball implements Displayable, Moveable {
  int time;
  boolean goingdown;
  int direction;
  int velocity;
  EarthBall(float x, float y) {

    super(x, y);
    time = millis();
    goingdown = true;
    direction = 1;
    velocity=0;
  }
  void display() {
    noStroke();
    fill(142, 100, 64);
    ellipse(x, y, 50, 50);
  }

  float a = random(-5, 5);
  float b = random(-5, 5);
  void move() {
    if (!(x < 950) || !(x > 0)) {
      direction*=1;
    }
    if (y > 750) {
      goingdown=true;
      velocity=0;
    }
    if (goingdown==true) {
      x+=0.2*direction;
      velocity+=9.81;
      y += velocity;
      time=millis();
    } else {
      time+=0.1;
      x+=0.2*direction;
      y = 750 - 1/2*9.81*time*time;
    }
  }
}


ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    BBall b = new BBall(50+random(width-100), 50+random(height)-100);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(60+random(width-100), 60+random(height)-100);
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
