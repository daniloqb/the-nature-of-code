Vehicle vehicle;


void setup(){
 
  size(1024,768);
  frameRate(30);
  PVector p_center = new PVector(width/2, height/2);  
  vehicle = new Vehicle(p_center);
  
}


void draw(){
  background(0);
  println(frameRate);
  vehicle.update();
}