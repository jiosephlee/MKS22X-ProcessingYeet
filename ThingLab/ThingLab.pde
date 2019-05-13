interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable {
  boolean isTouching(Thing other);
}

class Thing implements Collideable {
  float x, y;
  float size;

  Thing(float x, float y, float s) {
    this.x = x;
    this.y = y;
    size = s;
  }

  boolean isTouching(Thing other) {
    if (other.x <= (this.x + 50) && other.x >= (this.x - 50)
      && other.y <= (this.y + 50) && other.y >= (this.y - 50)) {
      return true;
    }
    return false;
  }
}

class Rock extends Thing implements Displayable {
  float size;
  PImage rock;
  Rock(float x, float y, PImage r) {
    super(x, y, 20);
    size = 20;
    rock = r;
  }


  float ran1 = random(20) + 30;
  float ran2 = random(20) + 30;


  void display() {
    image(rock, x, y, 50, 50);
  }
}

public class LivingRock extends Rock implements Moveable {
  float[] eyeColors = new float[] { random(0, 255), random(0, 255), random(0, 255) };
  int[] xChanges = new int[] { 5, 0, -10, 0 };
  int[] yChanges = new int[] { 0, 5, 0, -10 };

  LivingRock(float x, float y, PImage r) {
    super(x, y, r);
  }

  void display() {
    super.display();
    fill(255);

    ellipse(x+15, y +15, 20, 20);
    ellipse(x+35, y +15, 15, 15);

    fill(eyeColors[0], eyeColors[1], eyeColors[2]);
    ellipse(x+15, y +18, 10, 10);
    ellipse(x+35, y+ 15, 10, 10);
    fill(0);
    ellipse(x+15, y+18, 7, 7);
    ellipse(x+35, y+15, 7, 7);
  }



  float z= 1;
  float mouseXP = -1;
  float mouseYP = -1;

  void move() {
    /*if ((x < 950) && (x > 10)){
     x += z;
     }
     if ((y < 740) && (y > 10)){

     y += g;
     }*/
    if ((mouseX < 950) && (mouseY > 10) && (mouseX != mouseXP || x > mouseX + 7 || x < mouseX - 7)) {
      if (mouseX > x) {
        x += z;
      } else {
        x -= z;
      }
    }
    if ((mouseY < 740) && (mouseY > 10) && (mouseY != mouseYP || y > mouseY + 7 || y < mouseY - 7)) {
      if (mouseY > y) {
        y += z;
      } else {
        y -= z;
      }
    }
    mouseXP = mouseX;
    mouseYP = mouseY;
    //if touching thing should go here for collisions but I don't know which other thing to use?
  }
}

class Ball extends Thing implements Displayable, Moveable {
  int velocity, dirx, diry;
  float vx, vy;
  boolean collide = false;

  Ball(float x, float y) {
    super(x, y, 20);
    velocity = (int)random(2) + 2;
    vx = random(velocity-1)+1;
    vy = velocity*velocity - (vx*vx);
    if (random(1) < 0.5) {
      dirx = 1;
    } else {
      dirx = -1;
    }
    if (random(1) < 0.5) {
      diry = 1;
    } else {
      diry = -1;
    }
  }

  float r = random(255);
  float g = random(255);
  float bl = random(255);

  float size = random(30, 50);
  void setdiry(int a) {
    diry = a;
  }
  void setdirx(int a) {
    dirx = a;
  }
  void display() {
    noStroke();
    fill(r, g, bl);
    ellipse(x, y, size, size);
  }

  void move() {
    if ((x > 960) || (x < 20)) {
      dirx*=-1;
      x += vx * dirx;
      y += vy * diry;
    } else if ((y > 760) || (y < 20)) {
      diry*=-1;
      x += vx * dirx;
      y += vy * diry;
    } else {
      x += vx * dirx;
      y += vy * diry;
    }

    for (Collideable c : ListOfCollideables) {
      if (c.isTouching(this)) {
        this.collide = true;
      }
    }

    if (this.collide == true) {
      dirx*=-1;
      diry*=-1;
      vx = (vx + random(velocity-1)+1)/2;
      vy = velocity*velocity - (vx*vx);
      x += vx * dirx;
      y += vy * diry;
    }
  }
}

class BBall extends Ball implements Displayable, Moveable {

  PImage google;
  BBall (float x, float y, PImage g) {
    super(x, y);
    google = g;
  }

  void fixcoordinates(ArrayList<Collideable> b) {
    int count = 0;
    for (Collideable r : b) {
      if (r.isTouching(this)) {
        x = (50+random(height-110));
        y = (50+random(width-110));
        count++;
      }
    }
    if (count !=0) {
      fixcoordinates(b);
    } else {
      return;
    }
  }
  void display() {
    if (collide) {
      fill(255, 0, 0);
      ellipse(x+25, y+25, 50, 50);
    } else {
      image(google, x, y, 50, 50);
    }
    collide = false;
  }

  void move() {
    super.move();
  }
}

class EarthBall extends Ball implements Displayable, Moveable {
  int time;
  float friction;
  boolean wasPressed;
  EarthBall(float x, float y, float friction) {
    super(x, y);
    vy = 0;
    vx = 1;
    diry = -1;
    time = millis();
    this.friction = friction;
  }
  void display() {
    if (collide) {
      fill(0, 0, 255);
      ellipse(x, y, 50, 50);
    } else {
      noStroke();
      fill(142, 100, 64);
      ellipse(x, y, 50, 50);
    }
    collide = false;
  }

  void move() {
    if (vy < 0.005 && y > 759) {
      vy = 0;
      y = 760;
    }
    if ((x > 960) || (x < 20)) {
      dirx*=-1;
      velocity+=9.91 * (millis()-time) / 1000;
      x += vx * dirx;
      y += vy * diry;
      time = millis();
    } else if ((y > 760) || (y < 20) || vy <= 0) {
      diry*=-1;
      if (vy <= 0) {
        vy=9.91 * (millis()-time) / 1000;
        x += vx * dirx;
        y += vy * diry;
      } else {
        x += vx * dirx;
        y += vy * diry;
        vy-=((9.81 + friction) * (millis()-time) / 1000) * (10/vy); // simulates air resistance but also creates the fast bouncing effect we see in earth
      }
      time = millis();
    } else if (diry == 1) {
      vy+=9.81 * (millis()-time) / 1000;
      x += vx * dirx;
      y += vy * diry;
      time = millis();
    } else {
      vy-=(9.81 + friction )* (millis()-time) / 1000; // stimulates air resistance
      x += vx * dirx;
      y += vy * diry;
      time = millis();
    }
    for (Collideable c : ListOfCollideables) {
      if (c.isTouching(this)) {
        this.collide = true;
      }
    }
  }

  void addVerticalV() {
    vy = 15;
    diry = -1;
  }
}


ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;
ArrayList<BBall> beachBalls;
ArrayList<EarthBall> earthBalls;

void setup() {
  size(1000, 800);
  PImage rock;
  PImage rock1;
  PImage google = loadImage("ball.png");

  rock = loadImage("rock.png");
  rock1 = loadImage("rock1.png");
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfCollideables = new ArrayList<Collideable>();
  beachBalls = new ArrayList<BBall>();
  earthBalls = new ArrayList<EarthBall>();
  for (int i = 0; i < 6; i++) {
    PImage rockimage;
    int n = (int)random(2);
    if (n == 1) rockimage = rock;
    else rockimage = rock1;
    Rock r = new Rock(50+random(width-110), 50+random(height-110), rockimage);
    thingsToDisplay.add(r);
    ListOfCollideables.add(r);
  }
  for (int i = 0; i < 5; i++) {
    BBall b = new BBall(50+random(width-110), 50+random(height-110), google);
    b.fixcoordinates(ListOfCollideables);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    beachBalls.add(b);
    EarthBall e = new EarthBall(50+random(width-110),50+random(height-110),0.3);//0.3 is the recommended co-effictient for aesthetics
    earthBalls.add(e);
    thingsToDisplay.add(e);
    thingsToMove.add(e);
  }

  LivingRock m = new LivingRock(50+random(width-100), 50+random(height)-100, rock);
  thingsToDisplay.add(m);
  thingsToMove.add(m);
  ListOfCollideables.add(m);
}

boolean wasMousePressed = false;
//boolean movedBall = false;
EarthBall pressed = null;
void createRocks(){

  if (mousePressed && !wasMousePressed){
    boolean onRock = false;
    for (EarthBall e : earthBalls) {
      if (abs(e.x-mouseX) <= 25 && abs(e.y-mouseY) <= 25) {
        onRock = true;
        pressed = e;
      }
    }
    if (!onRock) {
      EarthBall e = new EarthBall(50+random(width-110),50+random(height-110),0.3);//0.3 is the recommended co-effictient for aesthetics
      earthBalls.add(e);
      thingsToDisplay.add(e);
      thingsToMove.add(e);
      wasMousePressed = true;
    }
   // if (onRock) {
     // pressed.y -= 100;
    //}
  }
  else if (mousePressed){
     wasMousePressed = true;
     //movedBall = false;
  }
  else{
    if (pressed != null) {
    //  pressed.y -= 500;
      pressed.addVerticalV();
      pressed = null;
    //  movedBall = true;
    }
    wasMousePressed = false;
  }
}

void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
  createRocks();
}
