class Spring{

  PVector anchor;
  float len;
  float k = 0.05;
  
  Spring(float x, float y, float l){
    anchor = new PVector(x,y);
    len = l; 
  
  }
  
  void connect(Mover m){
  
    PVector force = PVector.sub(m.location, anchor);
    float d = force.mag();
    float stretch = d - len;
    force.normalize();
    force.mult(-1 * k * stretch);
    m.applyForce(force);
  }
  
  void display(){
    fill(100);
    rectMode(CENTER);
    rect(anchor.x,anchor.y,10,10);
  }
  
  void displayLine(Mover m){
  
    stroke(255);
    line(m.location.x,m.location.y,anchor.x,anchor.y);
  
  }

}


class Mover{
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float mass;
  
  
  Mover(float m, float x, float y){
   
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 5;
    mass = m;
  }
  
  void update(){
   velocity.add(acceleration);
   velocity.limit(topspeed);
   location.add(velocity); 

    acceleration.mult(0);
  }
  
  void display(){
   stroke(0);
   fill(175,150);
   ellipse(location.x,location.y,mass*16,mass*16);
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
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




Mover mover;
Spring spring;


void setup(){
  size(600,360);
  
  mover = new Mover(1,250,250);
  spring = new Spring(300,100,100);
  

}


void draw(){
 
  
  background(255);
  
  spring.connect(mover);
  
  PVector gravity = new PVector(0,0.01 * mover.mass);
  float c = 0.001;
  PVector friction = PVector.mult(mover.velocity,-1);
  friction.normalize();
  friction.mult(c);
  
  mover.applyForce(gravity);  
  mover.applyForce(friction);


    
    spring.display();
    spring.displayLine(mover);

    mover.update();
    mover.checkEdges();
    mover.display();
  
}