
class PVect{
 
  float x;
  float y;
  
  PVect(float x_, float y_){
    x = x_;
    y = y_;
  }
  
  void add(PVect v){
   
    x += v.x;
    y += v.y;
  }
  
}

PVect location;
PVect velocity;

void setup(){
  size(600,360);
  background(255);
  
  location = new PVect(100,100);
  velocity = new PVect(2.5,5);

}


void draw(){

  background(255);
  

  location.add(velocity);
  
  if ((location.x > width)||(location.x < 0)){
        velocity.x *= -1;
   }
    
  if ((location.y > height)||(location.y < 0)){
      velocity.y *= -1;
  }

  stroke(0);
  fill(175);
  
  ellipse(location.x,location.y,16,16);

}