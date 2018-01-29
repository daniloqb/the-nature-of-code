class Target{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  color c1;
  int size = 16;
  
  Target(PVector l){
    location = l;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    c1 = color(255,0,255);
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
   fill(c1);
   ellipse(location.x,location.y,size,size);
  }
  
  void run(){
    update();
    display();
  }
  
  
  void checkCollision(Rocket[] rockets){
    for (int i = 0; i < rockets.length; i++){
      float d = dist(location.x, location.y, rockets[i].location.x, rockets[i].location.y);
      if (d < ((target.size + rockets[i].size)/2)){
       rockets[i].completed = true; 
       rockets[i].c1 = color(0,255,0);
 
      }
    }
  }
  

  
}