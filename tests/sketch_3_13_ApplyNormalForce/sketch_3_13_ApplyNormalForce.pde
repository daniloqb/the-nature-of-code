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
float angle =PI/4;


void setup(){
  size(600,360);
  
  mover = new Mover(1,width/2,0);
  

}


void draw(){
 
  
  background(255);


    
    
   
    /*
    PVector wind = new PVector(0.001,0);
    
    float c = 0.01;
    PVector friction = PVector.mult(mover.velocity,-1);
    friction.normalize();
    friction.mult(c);
    
    mover.applyForce(friction);
    mover.applyForce(wind);
    
    */
    
    PVector gravity = new PVector(0,0.01 * mover.mass);
    
    PVector normal = new PVector();
    
    float mag = gravity.mag();
    
    normal.set(mag*sin(PI - angle), mag*cos(PI - angle),0);
    
    mover.applyForce(normal);
    mover.applyForce(gravity);
    mover.update();
    mover.checkEdges();
    mover.display();
    
    pushMatrix();
    translate(width/2,0);
    line(0,0,100*sin(angle),100*cos(angle));
    popMatrix();
  
}