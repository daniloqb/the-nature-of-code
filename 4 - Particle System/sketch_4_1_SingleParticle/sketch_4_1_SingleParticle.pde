class Particle{
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  
  Particle(PVector l){
   
    location = l.copy();
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    lifespan = 400;
  }
  
  boolean isDead(){
  
    if (lifespan < 0.0){
     return true; 
    }
    else{
      return false;
    }
  
  }
  
  void update(){
   velocity.add(acceleration);
   location.add(velocity); 
   lifespan -=2;

    acceleration.mult(0);
  }
  
  void display(){
   stroke(0,lifespan);
   fill(175,lifespan);
   ellipse(location.x,location.y,16,16);
  }
  
  void applyForce(PVector force){
    acceleration.add(force);
    
  }
  
  void checkEdges(){
   if (location.x > width){
     location.x = width;
     velocity.x *= -1;
   }
   else if(location.x < 0){
     location.x = 0;
     velocity.x *= -1;
   }
   
   if (location.y > height){
     location.y = height;
     velocity.y *= -1;
   }
   else if(location.y < 0){
     location.y = 0;
     velocity.y *= -1;
   }
  }
}




Particle p;
PVector gravity;

void setup(){
  size(600,360);
  p = new Particle(new PVector(width/2,10));
  gravity = new PVector(0,0.01);
  background(255);
}


void draw(){
 
  
  

  p.applyForce(gravity);
  p.update();
  p.checkEdges();
  p.display();

}