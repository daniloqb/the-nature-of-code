
Vehicle vehicle;
Vehicle seek;

float r;

PVector mouse_target;
 PVector point_target;



void setup(){
 
  size(1024,768);

  mouse_target = new PVector(width/2, height/2);
  
  point_target = new PVector(width/2 + 150, height/2);  

  vehicle = new Vehicle(new PVector(0,height/2));

  

}


void draw(){
  background(0);

  vehicle.seekAndAvoid(point_target);
    vehicle.seekAndAvoid(point_target2);
  vehicle.update();
//display_mouse_target();
   
}

void mouseClicked(){
 
  vehicle.location.x = mouseX;
  vehicle.location.y = mouseY;
}

void display_mouse_target(){
   r =  50;
  
  noFill();
  stroke(255,0,0);
  ellipse(mouse_target.x, mouse_target.y, r*2,r*2);
  
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