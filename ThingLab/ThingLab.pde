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

<<<<<<< HEAD
  void display() {  
      
=======
  float ran1 = random(20) + 30;
  float ran2 = random(20) + 30;
  void display() { 
      fill(150); 
      ellipse(x, y, ran1, ran2);
>>>>>>> 1d099f373be28e8aa52024e538bf4337c33e642f
  }
}

public class LivingRock extends Rock implements Moveable {
<<<<<<< HEAD
  int[] xChanges = new int[] { 5, 0, -10, 0 };
  int[] yChanges = new int[] { 0, 5, 0, -10 };
  int i = 0;
  
=======
>>>>>>> 1d099f373be28e8aa52024e538bf4337c33e642f
  LivingRock(float x, float y) {
    super(x,y);
  }
  void move() {
<<<<<<< HEAD
    i++;
    if (i == 4) i = 0;
    x += xChanges[i];
    y += yChanges[i];
    translate(x,y);
=======
    /* ONE PERSON WRITE THIS */
>>>>>>> 1d099f373be28e8aa52024e538bf4337c33e642f
  }
}

class Ball extends Thing implements Displayable, Moveable {
  Ball(float x, float y) {

    super(x, y);
  }

<<<<<<< HEAD
    void display() {
    /*
    noStroke();
    fill(255, 211, 250);
    ellipse(x, y, 50, 50);*/
    image(ball, x, y, 50, 50);
=======
  void display() {
<<<<<<< HEAD
    /* ONE PERSON WRITE THIS */
=======
    noStroke();
    fill(255, 211, 250);
    ellipse(500, 400, 50, 50);
>>>>>>> 1d099f373be28e8aa52024e538bf4337c33e642f
>>>>>>> f633356ed375d1435a53ba1551c52cf71df842e2
  }

  void move() {
    ellipse(x + 1, y + 1, 33, 33);
  }
<<<<<<< HEAD
  void mousepressed(){
    ellipse(mouseX, mouseY, 33, 33);
  }
}
=======
  //void mousepressed(){
   // ellipse(mouseX, mouseY, 33, 33);
  }
>>>>>>> 1d099f373be28e8aa52024e538bf4337c33e642f
ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
PImage ball;

void setup() {
  size(1000, 800);
  ball=loadImage("ball.png"); 
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