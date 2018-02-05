
Vehicle vehicle;


PVector mouse_target;

void setup(){
 
  size(1024,768);

  mouse_target = new PVector(mouseX, mouseY);
  
  PVector p_center = new PVector(width, height/2);  
  vehicle = new Vehicle(new PVector(width/2, height/2));
  
}


void draw(){
  background(0);

   vehicle.arrive(mouse_target);
   
   vehicle.update();
  
   display_mouse_target();
   
}

void mouseClicked(){
 
  mouse_target.x = mouseX;
  mouse_target.y = mouseY;
}

void display_mouse_target(){
 
  float r =  0.5*((vehicle.max_speed*vehicle.max_speed)/vehicle.max_force);
  noFill();
  stroke(255,0,0);
  ellipse(mouse_target.x, mouse_target.y, r,r);
  
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      vehicle.max_speed += 1;
    } else if (keyCode == DOWN) {
      vehicle.max_speed -= 1;
    } 
  }
  
  vehicle.max_speed = constrain(vehicle.max_speed,0,20);
}