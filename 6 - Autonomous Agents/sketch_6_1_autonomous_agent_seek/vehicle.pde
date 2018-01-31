class Vehicle{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float r = 4;
  
  float max_speed = 4;
  float max_force = 0.15;
  
  
  Vehicle(float x, float y){
    location = new PVector(x,y);
    velocity = PVector.random2D();
    velocity.limit(max_speed);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector force){
   acceleration.add(force); 
  }
  void update(){    
    velocity.add(acceleration);
    velocity.limit(max_speed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display(){
    float angle = velocity.heading() +PI/2;  
    fill(255,0,255);
    noStroke();
    
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    beginShape();
    vertex(0,-r*2);
    vertex(-r,r*2);
    vertex(r,r*2);
    endShape(CLOSE);
    //ellipse(0, 0, r, r);
    popMatrix();
  }
  
  void seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.setMag(max_speed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(max_force);
    applyForce(steer);
  }
  
}