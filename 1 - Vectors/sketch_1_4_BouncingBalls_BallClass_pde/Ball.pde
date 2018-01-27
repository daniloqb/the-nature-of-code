
class Ball{
  
  PVector location;
  PVector velocity;
  
  Ball(){
    location = new PVector(width/2, height/2);
    velocity = new PVector(1,0.5);
  }

  void move(){
    
   location.add(velocity);
   
     if ((location.x > width)||(location.x < 0)){
        velocity.x *= -1;
   }
    
  if ((location.y > height)||(location.y < 0)){
      velocity.y *= -1;
  }
    
  }
  
  void display(){
   
    
  stroke(0);
  fill(175);
  
  ellipse(location.x,location.y,16,16);
    
  }


}