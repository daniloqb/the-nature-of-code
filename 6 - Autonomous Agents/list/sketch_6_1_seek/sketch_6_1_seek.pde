Vehicle vehicle;

PVector mouse_target;

void setup(){
 
  size(1024,768);

  mouse_target = new PVector(mouseX, mouseY);
  
  PVector p_center = new PVector(width/2, height/2);  
  vehicle = new Vehicle(p_center);
  
  
}


void draw(){
  background(0);

  vehicle.seek(mouse_target);
  vehicle.update();
  
  
  display_mouse_target();
}


void mouseClicked(){
 
  mouse_target.x = mouseX;
  mouse_target.y = mouseY;
}

void display_mouse_target(){
 
  float r = 40;
  noFill();
  stroke(255,0,0);
  ellipse(mouse_target.x, mouse_target.y,r,r);
  
}