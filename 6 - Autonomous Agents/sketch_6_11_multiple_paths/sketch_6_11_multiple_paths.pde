Path path;
ArrayList<Vehicle> vehicles;
float z = 0.1;
void setup(){
  size(800,600);
   newPath();
   vehicles = new ArrayList<Vehicle>();
   vehicles.add(new Vehicle(new PVector(random(width) ,random(height))));
}


void draw(){  
 background(255);
 newPath();
 for(Vehicle v: vehicles){
     v.folow_path(path);
     v.borders(path);
     v.avoid3(new PVector(mouseX,mouseY));
     v.update();
  }
 
 
// path.display();
 
}



void mouseClicked(){
 
 for (int i = 0; i < 10; i++) 
  vehicles.add(new Vehicle(new PVector(mouseX, mouseY)));
}

void newPath(){
  path = new Path();
  //path.addPoint(-20, height/2);
  //path.addPoint(random(0, width/2), random(0, height));
  //path.addPoint(random(width/2, width), random(0, height));
  //path.addPoint(width+20, height/2);
  
  
  float w = width / 50;
  
  for (int i = 0; i < 51; i++){
    float v = i * w;
   float angle = map(v,0,width,0,TWO_PI*3); 
   
   path.addPoint(v,sin(angle+z)*100 + height/2);
  }
  z += 0.01;
  
}