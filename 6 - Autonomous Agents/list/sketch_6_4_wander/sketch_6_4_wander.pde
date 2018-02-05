Vehicle wander;
Vehicle vehicle;

PVector mouse_target;

void setup(){
 
  size(1024,768);

  mouse_target = new PVector(mouseX, mouseY);
  
  PVector p_center = new PVector(width, height/2);  
  wander = new Vehicle(p_center);
  vehicle = new Vehicle(new PVector(width/2, height/2));
  
  wander.col = color(255,60,255);
  wander.max_speed=4;
}


void draw(){
  background(0);

  wander.wander();
  vehicle.rendezvou(wander.location, wander.velocity);
    
  wander.update();
  vehicle.update();
  
//  display_mouse_target();
}


void mouseClicked(){
 
  //mouse_target.x = mouseX;
  //mouse_target.y = mouseY;
 
  wander.location.x = mouseX;
  wander.location.y = mouseY;
  wander.velocity = new PVector(random(-wander.max_speed, wander.max_speed),random(-wander.max_speed,wander.max_speed));
  
}

void display_mouse_target(){
 
  float r = 40;
  noFill();
  stroke(255,0,0);
  ellipse(mouse_target.x, mouse_target.y,r,r);
  
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      wander.max_speed += 1;
    } else if (keyCode == DOWN) {
      wander.max_speed -= 1;
    } 
  }
  
  wander.max_speed = constrain(wander.max_speed,0,20);
  
}