import java.util.*;


class Particle{
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float lifespan;
  float mass = 1;
  
  float angle;
  float aVelocity;
  float aAcceleration;
  
  
  Particle(PVector l){
   Random generator;
   generator = new Random();
    
   float vx = (float) generator.nextGaussian()*0.3;
   float vy = (float) generator.nextGaussian()*0.3 -1.0;
   
    location = l.copy();
    velocity = new PVector(vx,vy);
    acceleration = new PVector(0,0);
    lifespan = 400;
    
    angle = 0;
    aVelocity = 0;
    aAcceleration = 0;
    
    
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
   
   aAcceleration = acceleration.mag() / 10;
   aVelocity += aAcceleration;
   angle += aVelocity;
   

    acceleration.mult(0);
  }
  
  void display(){
   stroke(0,lifespan);
   fill(175,lifespan);
   
   pushMatrix();
   translate(location.x, location.y);
   rotate(angle);
   //line(0,0,10,10);
   ellipse(0,0,10,10);
   popMatrix();
  }
  
  void run(){
  
    update();
    display();
  
  }
  
  void applyForce(PVector force){
    PVector f = force.copy();
    f.div(mass);
    acceleration.add(f);
    
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