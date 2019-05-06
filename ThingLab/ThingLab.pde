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
  Rock(float x, float y) {
    super(x, y);
  }

  float ran1 = random(20) + 30;
  float ran2 = random(20) + 30;
  void display() { 
      fill(150); 
      ellipse(x, y, ran1, ran2);
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x,y);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
  }
}

class Ball extends Thing implements Displayable, Moveable {
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    noStroke();
    fill(255, 211, 250);
    ellipse(500, 400, 50, 50);
  }

  void move() {
    ellipse(x + 1, y + 1, 33, 33);
  }
  //void mousepressed(){
   // ellipse(mouseX, mouseY, 33, 33);
  }
ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100),50+random(height)-100);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100),50+random(height)-100);
    thingsToDisplay.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100),50+random(height)-100);
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