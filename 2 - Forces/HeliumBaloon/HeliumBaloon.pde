class Mover{
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  
  Mover(){
   
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 5;
  }
  
  void update(){
   velocity.add(acceleration);
   velocity.limit(topspeed);
   location.add(velocity); 

    acceleration.mult(0);
  }
  
  void display(){
   stroke(0);
   fill(175);
   ellipse(location.x,location.y,16,16);
  }
  
  void applyForce(PVector force){
    acceleration.add(force);
    
  }
  
  void checkEdges(){
   if (location.x > width){
     location.x = width;
     velocity.x = 0;
   }
   else if(location.x < 0){
     location.x = 0;
     velocity.x = 0;
   }
   
   if (location.y > height){
     location.y = height;
     velocity.y = 0;
   }
   else if(location.y < 0){
     location.y = 0;
     velocity.y = 0;
   }
  }
}




Mover mover;
PVector gravity;
PVector helium;

float t = 0;

void setup(){
  size(600,360);
  mover = new Mover();
  gravity = new PVector(0,0.01);
  helium = new PVector(0,-0.011);
}


void draw(){
 
  
  background(255);

  mover.applyForce(gravity);
  mover.applyForce(helium);
  mover.applyForce(new PVector((noise(t)*0.001),0));
  mover.update();
  mover.checkEdges();
  mover.display();

  t +=0.01;
}