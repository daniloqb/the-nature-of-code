Vehicle vehicle;
Vehicle pursuit;
Vehicle pursuit2;
Vehicle pursuit3;

Vehicle seek;

PVector mouse_target;

void setup(){
 
  size(1024,768);

  mouse_target = new PVector(mouseX, mouseY);
  
  PVector p_center = new PVector(width, height/2);  
  vehicle = new Vehicle(p_center);
  pursuit = new Vehicle( new PVector(0, height-80));
  pursuit2 = new Vehicle( new PVector(0, height-80));
  pursuit3 = new Vehicle( new PVector(0, height-80));


  seek = new Vehicle( new PVector(0, height-80));
  
 // vehicle.velocity = new PVector(-1,0);
 // pursuit.velocity = new PVector(0,4);
 // pursuit.max_speed = 4;
  vehicle.max_speed = 4;
  
  vehicle.col = color(255,255,255);
  pursuit.col = color(255,0,0);
  pursuit2.col = color(0,255,0);
  pursuit3.col = color(0,0,255);
  seek.col = color(255,255,0);
  
}


void draw(){
  background(0);

  pursuit.pursuit(vehicle.location, vehicle.velocity);
  pursuit2.pursuit2(vehicle.location, vehicle.velocity);
  pursuit3.pursuit3(vehicle.location, vehicle.velocity);

  seek.seek(vehicle.location);
    
  vehicle.update();
  pursuit.update();
  pursuit2.update();
  pursuit3.update();

  seek.update();
  
//  display_mouse_target();
}


void mouseClicked(){
 
  //mouse_target.x = mouseX;
  //mouse_target.y = mouseY;
  
  vehicle.location.x = mouseX;
  vehicle.location.y = mouseY;
  vehicle.velocity = new PVector(random(-vehicle.max_speed, vehicle.max_speed),random(-vehicle.max_speed,vehicle.max_speed));
}

void display_mouse_target(){
 
  float r = 40;
  noFill();
  stroke(255,0,0);
  ellipse(mouse_target.x, mouse_target.y,r,r);

  
}