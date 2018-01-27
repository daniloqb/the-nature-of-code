class Mover{
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  float angle;
  
  
  Mover(){
   
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 5;
    
    angle = 0;
  }
  
  void update(){
    velocity.add(acceleration);
    velocity.limit(topspeed);
   location.add(velocity); 
   velocity.mult(0.99);

  }
  
  void display(){
   stroke(0);
   fill(175);
   angle = velocity.heading();
   rectMode(CENTER);
   pushMatrix();   
   translate(location.x,location.y);
   rotate(angle);
   rect(0,0,16,16);
   
   popMatrix();
  }
  
  void checkEdges(){
   if (location.x > width){
     location.x = 0;
   }
   else if(location.x < 0){
     location.x = width;
   }
   
   if (location.y > height){
     location.y = 0;
   }
   else if(location.y < 0){
     location.y = height;
   }
  }
}




Mover mover;

void setup(){
  size(600,360);
  mover = new Mover();

}


void draw(){
 
  background(255);
  mover.update();
  mover.checkEdges();
  mover.display();
  println(mover.velocity.mag()+" "+mover.acceleration.mag());
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
        mover.acceleration.add(new PVector(0,-0.01));
    } else if (keyCode == DOWN) {
      mover.acceleration.add(new PVector(0,0.01));

    } 
     else if (keyCode == LEFT) {
      mover.acceleration.add(new PVector(-0.01,0));

    } 
     else if (keyCode == RIGHT) {
      mover.acceleration.add(new PVector(0.01,0));

    } 
  } 
}

void keyReleased(){
 mover.acceleration.mult(0); 

}