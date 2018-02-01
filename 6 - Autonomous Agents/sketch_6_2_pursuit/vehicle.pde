class Vehicle{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float r = 4;
  color col = color(255,0,255);

  
  float max_speed;
  float max_force;
  
  
  Vehicle(float x, float y){
    max_speed = 4;
    max_force = 0.25;
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
  
  
  void avoid(PVector target,float r1,float r2){
  
   float act = velocity.mag();
   PVector vel = velocity.copy();
   vel.normalize();
   
   vel.mult( 0.5*((act*act)/max_force));

   vel.add(location);
   
   stroke(255);
   strokeWeight(10);
   point(vel.x,vel.y);
   strokeWeight(1);
   
   float d = PVector.dist(target,vel);

   
   if (d < (r1+r2)/2){
     flee(target);
   }
   
  }
  
  void arrive(PVector target){
    
    float distance;
    float slowing_distance;
    float ramped_speed;
    float clipped_speed;
   
    
    slowing_distance = 0.5*((max_speed*max_speed)/max_force);
    clipped_speed = max_speed;
    
    PVector target_offset = PVector.sub(target, location);
    distance = target_offset.mag();
    //ramped_speed = max_speed * (distance / slowing_distance);
    //clipped_speed = min(ramped_speed, max_speed);
    

    
    if (distance < slowing_distance){
      clipped_speed = map(distance,slowing_distance,0,max_speed,0);
    } 
    
    target_offset.setMag(clipped_speed);
    PVector steer = PVector.sub(target_offset,velocity);
    steer.limit(max_force);
    applyForce(steer);

  }
  
  void pursuit(Vehicle target){
   
    PVector desired = PVector.sub(target.location, location);
    
    float d = desired.mag();    
    desired.setMag(max_speed);
    float t = d / desired.mag();
    
    PVector p_velocity = target.velocity.copy().mult(t);
    PVector p_desired = PVector.sub(PVector.add(target.location, p_velocity),location);
    
    PVector steer = PVector.sub(p_desired,velocity);
    steer.limit(max_force);
    applyForce(steer);
    
  }
  
  void evade(Vehicle target){
   
    PVector desired = PVector.sub(target.location, location);
    
    float d = desired.mag();    
    desired.setMag(max_speed);
    float t = d / desired.mag();
    
    PVector p_velocity = target.velocity.copy().mult(t);
    PVector p_desired = PVector.sub(PVector.add(target.location, p_velocity),location);
    
    PVector steer = PVector.sub(p_desired,velocity);
    steer.mult(-1);
    steer.limit(max_force);
    applyForce(steer);
    
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