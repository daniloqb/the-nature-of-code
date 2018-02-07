Path path;
ArrayList<Vehicle> vehicles;

void setup(){
  size(800,600);
  path = new Path();
  path.addPoint(0,height/2);
  path.addPoint(width/2,height/2);
  path.addPoint(width,height/2);
   vehicles = new ArrayList<Vehicle>();
   vehicles.add(new Vehicle(new PVector(random(width) ,random(height))));
}


void draw(){  
 background(255);
 
 for(Vehicle v: vehicles){
     v.folow_path(path);
    v.update();
  }
 

 path.display();
}



void mouseClicked(){
 
 for (int i = 0; i < 1; i++) 
  vehicles.add(new Vehicle(new PVector(mouseX, mouseY)));
}