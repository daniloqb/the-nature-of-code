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
     wander_angle = 0;
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
    
    boundaries_pass();
    
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

PVector steer(PVector location_,PVector target_, PVector velocity_){
  
    PVector desired = PVector.sub(target_,location_);
    desired.setMag(max_speed);
    
    PVector steer = PVector.sub(desired,velocity_);
    steer.setMag(max_force);
    
    return steer;
  
}

  void seek(PVector target){
    PVector force = steer(location, target, velocity);
   
         applyForce(force);
  }
  
  void flee(PVector target){
     PVector force = steer(location, target, velocity);
     force.mult(-1);
     applyForce(force);
  }
  
    
 
  void pursuit(PVector target, PVector target_velocity){
  
    PVector distance = PVector.sub(target,location);
    float d = distance.mag();  
    //PVector dif = PVector.sub(velocity,target_velocity);
   // float factor = d/dif.mag();
    float factor = d/velocity.mag();
    
    
    PVector future_location = target_velocity.copy();    
    future_location.mult(factor);
    future_location.add(target);
    
    seek(future_location);
  }
  
   void evade(PVector target, PVector target_velocity){
  
    PVector distance = PVector.sub(target,location);
    float d = distance.mag();  
    //PVector dif = PVector.sub(velocity,target_velocity);
   // float factor = d/dif.mag();
    float factor = d/velocity.mag();
    
    
    PVector future_location = target_velocity.copy();    
    future_location.mult(factor);
    future_location.add(target);
    
    flee(future_location);
  }
  
  void rendezvou(PVector target, PVector target_velocity){
  
    PVector distance = PVector.sub(target,location);
    float d = distance.mag();  
   // PVector dif = PVector.sub(velocity,target_velocity);
    PVector dif = PVector.sub(target_velocity,velocity);
    dif.normalize();
   // float factor = d/dif.mag();
    
    float factor = d;
    dif.mult(factor);
    
    PVector future_location = target_velocity.copy();    
    //future_location.mult(factor);
    future_location.add(dif);
    future_location.add(target);
    
    
    seek(future_location);
  
  }
  
  
  void wander(){
    
   float act = velocity.mag();
    
   float sight = 0.5*((act*act)/max_force);
  //float sight = 100;
   PVector vel = velocity.copy();
  
   vel.normalize().mult(sight);
   vel.add(location);
  
   boundaries();
  
   if(random(1) < 0.01){
     wander_angle = random(-PI,PI);
   }
 
   float vx = cos(wander_angle) * sight;
   float vy = sin(wander_angle) * sight;
   
   PVector future = new PVector(vx,vy);
   future.add(vel);
   seek(future);
   
   noFill();
   stroke(255);
   strokeWeight(1);
   line(location.x, location.y,vel.x,vel.y);
   line(vel.x,vel.y, future.x,future.y);
   ellipse(vel.x,vel.y,sight*2,sight*2);
  }
  
  void arrive(PVector target){
    
    float distance;
    float slowing_distance;
    //float ramped_speed;
    float clipped_speed;
   
    
    slowing_distance = 0.5*((max_speed*max_speed)/max_force);
    clipped_speed = max_speed;
    
    PVector desired = PVector.sub(target, location);
    distance = desired.mag();
    //ramped_speed = max_speed * (distance / slowing_distance);
    //clipped_speed = min(ramped_speed, max_speed);
    

    
    if (distance < slowing_distance){
      clipped_speed = map(distance,slowing_distance,0,max_speed,0);
    } 
    
    desired.setMag(clipped_speed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(max_force);
    applyForce(steer);

  }
  
  
// void avoid(PVector target,float r1,float r2){
  
//   float act = velocity.mag();
//   PVector vel = velocity.copy();
//   vel.normalize();
   
//   vel.mult( 0.5*((act*act)/max_force));
//  // vel.mult( max_speed);

//   vel.add(location);
   
   
//   stroke(255);
//   strokeWeight(10);
//   point(vel.x,vel.y);
//   strokeWeight(1);
   
//   float d = PVector.dist(target,vel);
//println(d);
   
//   if (d < r1+r2){
//     flee(target);
//   }
   
//   noFill();
//   stroke(255,255,0);
//   ellipse(location.x, location.y,r1*2,r1*2);
//   stroke(255,0,255);
//   ellipse(target.x, target.y,r2,r2);
   
//  }
  
  void avoid2(PVector target,float r1,float r2){
  
    PVector distance = PVector.sub(target,location);
    float d_mag = distance.mag();
    
    float threshold = r1 + r2;
    float diff = threshold - d_mag;
    
    if (diff > 0){
       print(d_mag + " ");
       println("vai batter"); 
      // velocity.mult(0);
      distance.normalize();
      
      
      distance.mult(diff);
     // distance.mult(max_force);
    
      velocity = PVector.sub(velocity,distance);
      velocity.normalize();
      velocity.mult(max_speed);
    
    } else{
      print(d_mag + " ");
     println("livre"); 
    }
    

      
   noFill();
  // ellipseMode(RADIUS);
   stroke(255,255,0);
   ellipse(location.x, location.y,r1*2,r1*2);
   stroke(255,0,255);
   ellipse(target.x, target.y,r2*2,r2*2);
   
   
  }
  
  
  boolean avoid3(PVector target){
    

    
    float act = velocity.mag();
   // float lookahead = 40;
    float lookahead = 0.5*((act*act)/max_force);
   //float lookahead = max_speed;
    
    PVector ahead = velocity.copy().normalize();
    ahead.mult(lookahead);
    ahead.add(location);
    
    PVector distance = PVector.sub(target,ahead);
    float d_mag = distance.mag();
    float r1 = 10;
    float r2 = 50;
    float threshold = r1 + r2;
    float diff = threshold - d_mag;
    
    if (diff > 0){
       print(d_mag + " ");
       println("vai batter"); 
     // // velocity.mult(0);
     // distance.normalize();
      
      
     // distance.mult(diff);
     //// distance.mult(max_force);
    
     // velocity = PVector.sub(velocity,distance);
     // velocity.normalize();
     // velocity.mult(max_speed);
     
     PVector force = steer(ahead, target, velocity);
     force.mult(-1);
     applyForce(force);
     return true;
    
    } else{
 
     
     distance = PVector.sub(target,location);
     d_mag = distance.mag();
     diff = threshold - d_mag;
     if (diff > 0){
        print(d_mag + " ");
       println("vai batter"); 
       PVector force = steer(ahead, target, velocity);
     force.mult(-1);
     applyForce(force);
          return true;

     } else{
            print(d_mag + " ");
     println("livre"); 
     }
    }
    

      
   noFill();
  // ellipseMode(RADIUS);
   stroke(255,255,0);
   ellipse(location.x, location.y,r1*2,r1*2);
   stroke(255,0,255);
   ellipse(target.x, target.y,r2*2,r2*2);
   stroke(255);
   line(location.x,location.y,ahead.x, ahead.y);
   
   return false;
  }
  
  //void follow(FlowField flow){
  //  PVector desired = flow.lookup(location);
  //  desired.mult(max_speed);
    
  //  PVector steer = PVector.sub(desired, velocity);
  //  steer.limit(max_force);
  //  applyForce(steer);
  //  boundaries_pass();
  //}
  
  
  void folow_path(Path path){
   
     PVector predict = vehicle.velocity.copy();
 predict.normalize();
 predict.mult(25);
 PVector predictLoc = PVector.add(vehicle.location,predict);
 PVector a = PVector.sub(predictLoc,path.start);
 PVector b = PVector.sub(path.end,path.start);
 
 float theta = PVector.angleBetween(a,b);
 
 b.normalize();
 b.mult(a.dot(b));
 PVector normalPoint = PVector.add(path.start,b);
 
 float distance = PVector.dist(predictLoc,normalPoint);
 
 if (distance > path.radius){
   seek(normalPoint);
 }
    
    
  }
  
  
  
  void boundaries_pass(){
   
    if (location.x < 0){
      location.x =  width;
    } else if (location.x > width){
      location.x = 0;
    }
    if (location.y < 0){
      location.y =  height;
    } else if (location.y > height){
      location.y = 0;
    }
    
  }
  
  
  
}