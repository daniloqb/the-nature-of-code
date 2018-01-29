class Target{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  int size = 16;

  Target(PVector l){
    location = l;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector f){
    
   acceleration.add(f); 
  }
  
  void update(){
   velocity.add(acceleration);
   location.add(velocity);
   acceleration.mult(0);
    
  }
  
  void display(){
   stroke(0);
   fill(255,0,0);
   ellipse(location.x,location.y,size,size);
  }
  
  void run(){
    update();
    display();
  }
  

  
}