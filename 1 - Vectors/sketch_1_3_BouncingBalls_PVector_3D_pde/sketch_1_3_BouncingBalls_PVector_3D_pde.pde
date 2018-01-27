
class PVect3D{
 
  float x;
  float y;
  float z;
  
  PVect3D(float x_, float y_, float z_){
    x = x_;
    y = y_;
    z = z_;
  }
  
  void add(PVect3D v){
   
    x += v.x;
    y += v.y;
    z += v.z;
  }
  
}

PVect3D location;
PVect3D velocity;

void setup(){
  size(600,360,P3D);
  background(255);
  
  location = new PVect3D(100,100,0);
  velocity = new PVect3D(2.5,5,0.5);

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
  
    if ((location.z > 500)||(location.z < 0)){
      velocity.z *= -1;
  }

  stroke(0);
  fill(175);
  
  translate(location.x,location.y,location.z);
  sphere(20);

}