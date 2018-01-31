class Vehicle{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float r = 4;
  color col = color(255,0,255);
  
  float max_speed = 4;
  float max_force = 0.15;
  
  
  Vehicle(float x, float y){
    location = new PVector(x,y);
    velocity = new PVector(random(-max_speed, max_speed),random(-max_speed,max_speed));
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
    
    boundaries();
  }
  
  void display(){
    float angle = velocity.heading() +PI/2;  
    fill(col);
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
  
  void flee(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.setMag(max_speed);
    PVector steer = PVector.sub(desired,velocity);
    steer.mult(-1);
    steer.limit(max_force);
    applyForce(steer);
  }
  
  void seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.setMag(max_speed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(max_force);
    applyForce(steer);
  }
  
  
  void boundaries(){
   if (location.x < 25){
     PVector desired = new PVector(max_speed,velocity.y);
     PVector steer = PVector.sub(desired,velocity);
     steer.limit(max_force);
     applyForce(steer);
  } else if (location.x > width -25){
     PVector desired = new PVector(-max_speed,velocity.y);
     PVector steer = PVector.sub(desired,velocity);
     steer.limit(max_force);
     applyForce(steer);
  }  
     if (location.y < 25){
     PVector desired = new PVector(velocity.x,max_speed);
     PVector steer = PVector.sub(desired,velocity);
     steer.limit(max_force);
     applyForce(steer);
  } else if (location.y > height -25){
     PVector desired = new PVector(velocity.x,-max_speed);
     PVector steer = PVector.sub(desired,velocity);
     steer.limit(max_force);
     applyForce(steer);
  }
  
}
}