Path path;
ArrayList<Vehicle> vehicles;

void setup(){
  size(800,600);
  path = new Path();
   vehicles = new ArrayList<Vehicle>();
   vehicles.add(new Vehicle(new PVector(width/2, height/2)));
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
 
 for (int i = 0; i < 500; i++) 
  vehicles.add(new Vehicle(new PVector(mouseX, mouseY)));
}