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

  int[] xChanges = new int[] { 5, 0, -10, 0 };
  int[] yChanges = new int[] { 0, 5, 0, -10 };
  int i = 0;

  LivingRock(float x, float y) {
    super(x, y);
  }
  
   void display() { 
      super.display();
  }
 
  float z= random(-10,10);
  float g = random(-10,10);
  
  void move() {
    if ((x < 950) && (x > 0)){
      x += z;
    }
    if ((y < 750) && (y > 25)){
      y += g;
    }
  }
}

class Ball extends Thing implements Displayable, Moveable {
  Ball(float x, float y) {

    super(x, y);
  }
  void display() {
    /*
    noStroke();
     fill(255, 211, 250);
     ellipse(x, y, 50, 50);*/
    image(ball, x, y, 50, 50);
  }



  float a = random(-5,5);
  float b = random(-5,5);
  int direction=1;
    
  void move() {
    if ((x < 950) && (x > 0) && (y < 750) && (y > 25)){
      x += a*direction;
      y += b*direction;
    } else{
      direction+=-1;
  }

}

class Ball extends Thing implements Displayable, Moveable {
  Ball(float x, float y) {

    super(x, y);
  }
  void display() {
    /*
    noStroke();
     fill(255, 211, 250);
     ellipse(x, y, 50, 50);*/
    image(ball, x, y, 50, 50);
  }



  float a = random(-5,5);
  float b = random(-5,5);
    
void move(){
  if (!(x < 950) || !(x > 0)){
        goingdown*=-1
      }
      if ((y < 750) && (y > 25)){
        y += g;
      }
  if(goingown==1){
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
PImage ball;
PImage rock;
PImage rockA;

void setup() {
  size(1000, 800);
  ball=loadImage("ball.png"); 
  rock=loadImage("rock.png");
  rockA=loadImage("rock1.png"); 
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