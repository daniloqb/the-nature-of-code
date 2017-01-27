class Pendulum{

  PVector origin;
  PVector location;
  
  
  float r;
  float angle;
  float aVelocity;
  float aAcceleration;
  
  
  Pendulum(PVector origin_, float r_){
  
    origin = origin_.get();
    location = new PVector();
    r = r_;
    
    angle = PI/4;
    
    aVelocity = 0;
    aAcceleration = 0;
  }
  
  
  void update(){
    
   float gravity = 1;
   aAcceleration = (-1 * gravity / r) * sin(angle);
   
   aVelocity += aAcceleration;
   angle += aVelocity;
   
   aVelocity *= 0.99;
    
  }
  
  void display(){
  
    location.set(r * sin(angle), r * cos(angle),0);
    location.add(origin);
    
    stroke(0);
    line(origin.x,origin.y,location.x,location.y);
    fill(175);
    ellipse(location.x,location.y,15,15);
  }
  
  
  void go(){
   
    update();
    display();
    
  }

}