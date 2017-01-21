class Mover{
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float mass;
  
  float angle;
  float aVelocity;
  float aAcceleration;
  
  
  Mover(float m, float x, float y){
   
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 5;
    mass = m;
    
    angle = 0.0;
    aVelocity = 0.0;
    aAcceleration = 0.0;
  }
  
  void update(){
   velocity.add(acceleration);
   location.add(velocity); 
   
   aAcceleration= acceleration.x/50;
   aVelocity += aAcceleration;
   angle += aVelocity;

    acceleration.mult(0);
  }
  
  void display(){
   stroke(0);
   fill(175,150);
   rectMode(CENTER);
   pushMatrix();
   translate(location.x,location.y);
   rotate(angle);
   line(-(mass*11/2),-(mass*11/2),mass*11/2,mass*11/2);
   ellipse(0,0,mass*16,mass*16);
   popMatrix();
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
    
  }
  
  void checkEdges(){
   if (location.x > width){
     location.x = width;
     velocity.x *= -1;
     aVelocity *= -1;
   }
   else if(location.x < 0){
     location.x = 0;
     velocity.x *= -1;
     aVelocity *= -1;
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




Mover mover;


void setup(){
  size(600,360);
  
  mover = new Mover(8,0,height);
  PVector cannon = new PVector(15,-15);
  mover.applyForce(cannon);


}


void draw(){
 
  
  background(255);


    
    PVector gravity = new PVector(0,0.1 * mover.mass);
    //PVector wind = new PVector(0.1,0);
    //float c = 0.01;
   
    
    //PVector friction = PVector.mult(mover.velocity,-1);
    //friction.normalize();
    //friction.mult(c);
    
    //mover.applyForce(friction);
    //mover.applyForce(wind);
    
    mover.applyForce(gravity);
    mover.update();
    mover.checkEdges();
    mover.display();
  
}