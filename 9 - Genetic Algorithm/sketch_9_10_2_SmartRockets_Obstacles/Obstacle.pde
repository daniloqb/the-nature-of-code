class Obstacle{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  color c1;
  int size = 50;
  
  Obstacle(PVector l){
    location = l;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    c1 = color(0,0,255);
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
  
  
  boolean checkCollision(Rocket target){

//    if(target.x > location.x && target.x < location.x +size && target.y > location.y && target.y < location.y + size){
//      return true;
//    }
//    return false; 
//  }
   
   float d = dist(location.x,location.y,target.location.x,target.location.y);
   
   if (d < (size + target.size)/2){
     return true;
   }
   return false;
}  
}