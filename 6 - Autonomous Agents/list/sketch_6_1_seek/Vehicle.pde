class Vehicle{
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float max_speed;
  float max_force;
  float r;
  float wander_angle;
  color col;
  
  Vehicle(PVector l){
     r = 3;
     max_speed = 4;
     max_force = 0.25;
     location = l;
     velocity = new PVector(random(-max_speed, max_speed),random(-max_speed,max_speed));
     acceleration = new PVector(0,0);
     col = color(random(255), random(255), random(255));
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
  
  void update(){    
    velocity.add(acceleration);
    velocity.limit(max_speed);
    location.add(velocity);
    acceleration.mult(0);
    
    boundaries();
    
    display();
  }
  
  void applyForce(PVector force){
   acceleration.add(force); 
  }
  
  void boundaries(){
    
   //float slowing_distance = 0.5*((velocity.mag()*velocity.mag())/max_force);
   float slowing_distance = 25;
   if (location.x < slowing_distance){
     PVector desired = new PVector(max_speed,velocity.y);
     PVector steer = PVector.sub(desired,velocity);
     steer.limit(max_force);
     applyForce(steer);
  } else if (location.x > width -slowing_distance){
     PVector desired = new PVector(-max_speed,velocity.y);
     PVector steer = PVector.sub(desired,velocity);
     steer.limit(max_force);
     applyForce(steer);

  }  
     if (location.y < slowing_distance){
     PVector desired = new PVector(velocity.x,max_speed);
     PVector steer = PVector.sub(desired,velocity);
     steer.limit(max_force);
     applyForce(steer);
  } else if (location.y > height  -slowing_distance){
     PVector desired = new PVector(velocity.x,-max_speed);
     PVector steer = PVector.sub(desired,velocity);
     steer.limit(max_force);
     applyForce(steer);
  }
  
}

  void seek(PVector target){
    PVector desired = PVector.sub(target,location);
    desired.setMag(max_speed);
    
    PVector steer = PVector.sub(desired,velocity);
    steer.setMag(max_force);
    
    applyForce(steer);
    
  }
  
}