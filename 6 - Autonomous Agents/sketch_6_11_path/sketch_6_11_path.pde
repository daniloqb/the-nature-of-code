
ArrayList<Vehicle> vehicles;
PVector mouse_target;
PVector point_target = new PVector(width/2, height/2);  

void setup(){
  size(800,600);
  
  mouse_target = new PVector(mouseX, mouseY);
  vehicles = new ArrayList<Vehicle>();
  
  for (int i =0; i < 100; i++){
   vehicles.add( new Vehicle( new PVector( random(width),random(height))));    
  }
}


void draw(){
 
  background(0);
  
  mouse_target.x = mouseX;
  mouse_target.y = mouseY;
  
  for (Vehicle v: vehicles){
   v.applyBehaviors(vehicles);
   v.update();
  }
  
}