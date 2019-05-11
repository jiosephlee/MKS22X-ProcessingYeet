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
  
  // if the distance between the two is smaller than half their sizes, they are overlapping
  boolean isTouching(Thing other) {
    return dist(this.x, this.y, other.x, other.y) <= (this.size + other.size) / 2;
  }
}

class Rock extends Thing implements Displayable{
  float size;
  PImage rock;
  Rock(float x, float y) {
    super(x, y, 20);
    size = 20;
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
    super(x, y, 20);
    velocity = (int)random(2) + 2;
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
    if((x > 960) || (x < 20)){
      dirx*=-1;
      x += vx * dirx;
      y += vy * diry;
    } else if ((y > 760) || (y < 20)) {
      diry*=-1;
      x += vx * dirx;
      y += vy * diry;
    } else{
      x += vx * dirx;
      y += vy * diry;
    }
    
    for (Collideable c : ListOfCollideables) {
      if (c.isTouching(this)) {
        // do something
      }
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
  EarthBall(float x, float y) {
    super(x, y);
    vy = 0;
    vx = 1;
    diry = -1;
    time = millis();
  }
  void display() {
    noStroke();
    fill(142, 100, 64);
    ellipse(x, y, 50, 50);
  }

  void move() {
    if((x > 960) || (x < 20)){
      dirx*=-1;
      velocity+=9.81 * (millis()-time) / 1000;
      x += vx * dirx;
      y += vy * diry;
      time = millis();
    } else if ((y > 760) || (y < 20) || vy <= 0) {
      diry*=-1;
      if (vy <= 0){
        vy=9.81 * (millis()-time) / 1000;
      } else{
        vy-=9.81 * (millis()-time) / 500; // this simulates air resistance but its just lowers velocity whenever it bounces
      }
      x += vx * dirx;
      y += vy * diry;
      time = millis();
    } else if (diry == 1){
      vy+=9.81 * (millis()-time) / 1000;
      x += vx * dirx;
      y += vy * diry;
      time = millis();
    } else{
      vy-=9.81 * (millis()-time) / 1000;
      x += vx * dirx;
      y += vy * diry;
      time = millis();
    }
  }
}


ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfCollideables = new ArrayList<Collideable>();
  for (int i = 0; i < 10; i++) {
    BBall b = new BBall(50+random(width-110), 50+random(height-110));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-110), 50+random(height-110));
    thingsToDisplay.add(r);
    ListOfCollideables.add(r);
  }
  EarthBall e = new EarthBall(100,100);
  thingsToDisplay.add(e);
  thingsToMove.add(e);
  LivingRock m = new LivingRock(50+random(width-100), 50+random(height)-100);
  thingsToDisplay.add(m);
  thingsToMove.add(m);
  ListOfCollideables.add(m);
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
