FlowField flow;


ArrayList<Vehicle> vehicles;

PVector center = new PVector(width/2,height/2);

void setup(){
  size(1024,768);
  frameRate(30);
  
  vehicles = new ArrayList<Vehicle>();
  flow = new FlowField();
  flow.generate();
  //vehicle = new Vehicle(new PVector(width/2, height/2));
  //vehicle.col = color(255,255,255);

  vehicles.add(new Vehicle(new PVector(width/2, height/2)));
  

  
}

void draw(){  //<>//
  background(0);
  flow.display_field();
//  flow.display_grid();
  flow.generate();
  //vehicle.follow(flow);
  //vehicle.update();
  

  
  for(Vehicle v: vehicles){
    v.follow(flow);
    v.flee(center);
    v.update();
  }
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      flow.vel_noise += 0.01;
    } else if (keyCode == DOWN) {
      flow.vel_noise -=0.01;
    } 
  }
  

}

void mouseClicked(){
 
 for (int i = 0; i < 500; i++) 
  vehicles.add(new Vehicle(new PVector(mouseX, mouseY)));
}