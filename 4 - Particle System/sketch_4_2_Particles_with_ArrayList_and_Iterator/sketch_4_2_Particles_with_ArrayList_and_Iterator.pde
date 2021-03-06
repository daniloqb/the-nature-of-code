import java.util.Iterator;

class Particle{
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  float angle;
  float aVelocity;
  float aAcceleration;
  
  
  Particle(PVector l){
   
    location = l.copy();
    velocity = new PVector(random(-2,2),random(-2,2));
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
   line(0,0,16,16);
   ellipse(0,0,16,16);
   popMatrix();
  }
  
  void run(){
  
    update();
    display();
  
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




ArrayList<Particle> particles;
PVector gravity;

void setup(){
  size(600,360);
  particles = new ArrayList<Particle>();
  gravity = new PVector(0,0.01);
}


void draw(){
   background(255);

  particles.add(new Particle(new PVector(width/2,50)));
  
  Iterator<Particle> it = particles.iterator();
  
  while (it.hasNext()){
   Particle p = it.next();
   p.applyForce(gravity);
   p.run();
   
   if (p.isDead()){
    it.remove(); 
   }
  }
  
  
  
  
  
  
  
  
  
  

}