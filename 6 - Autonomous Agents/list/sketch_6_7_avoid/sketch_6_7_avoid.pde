
Vehicle vehicle;
Vehicle seek;

float r;

PVector mouse_target;

void setup(){
 
  size(1024,768);

  mouse_target = new PVector(mouseX, mouseY);
  
  PVector p_center = new PVector(width/2, height/2);  
  vehicle = new Vehicle(p_center);
  seek = new Vehicle(new PVector(width, height/2));
  
  r =  0.5*((vehicle.max_speed*vehicle.max_speed)/vehicle.max_force);
}


void draw(){
  background(0);

 //  vehicle.avoid(mouse_target,3,r);
 //  vehicle.avoid2(mouse_target,50,100);
  
   vehicle.seekAndAvoid(seek.location);
 //vehicle.avoid3(mouse_target);
 //  seek.wander();
   seek.update();

   

   vehicle.update();
  
 //display_mouse_target();
   
}

void mouseClicked(){
 
  mouse_target.x = mouseX;
  mouse_target.y = mouseY;
}

void display_mouse_target(){
   r =  0.5*((vehicle.max_speed*vehicle.max_speed)/vehicle.max_force);

  
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
  vehicle.velocity.setMag(vehicle.max_speed);
}