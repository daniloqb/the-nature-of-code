class Liquid{
  
  float x,y,w,h;
  float c;
  
  Liquid(float x_,float y_, float w_, float h_, float c_){
    
   x = x_;
   y = y_;
   w = w_;
   h = h_;
   c = c_;
  }
  
  
  boolean contains(Mover m){
    boolean b = false;
    
    if((m.location.x >= x) && (m.location.x <= w)){
     
      if((m.location.y >= y) && (m.location.y <=h)){
        b = true;
      }
      
    }
    
    
    return b;   
  }
  
  
  PVector drag(Mover m){
    
   float speed = m.velocity.mag(); 
   float dragMag = c * speed * speed;
   PVector drag = PVector.mult(m.velocity,-1);
   drag.normalize();
   drag.mult(dragMag);
   
   return drag;
   
  }
  
  
  
  void display(){
    
   noStroke();
   fill(0,0,255);
   rect(x,y,w,h);
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
Liquid liquid;


void setup(){
  size(600,360);
  
  liquid = new Liquid(0,height/2,width,height/2,0.01);
  mover = new Mover(1,width/2,0);
  

}


void draw(){
 
  
  background(255);
 

    if(liquid.contains(mover)){
    
      PVector drag = liquid.drag(mover);

      mover.applyForce(drag);
    
      
    }
    mover.update();
    mover.checkEdges();
    mover.display();
  
}