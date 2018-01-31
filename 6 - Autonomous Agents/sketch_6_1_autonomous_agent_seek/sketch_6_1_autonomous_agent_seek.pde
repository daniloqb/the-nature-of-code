Vehicle vehicle;
PVector target;

void setup(){
  size(800,600);
  target = new PVector(random(width), random(height));
  vehicle = new Vehicle(width/2, height/2);

}

void draw(){
   background(0);

  
   
   fill(100,100,255);
   
   ellipse(target.x,target.y,30,30);

   vehicle.update();
   vehicle.seek(target);
   vehicle.display();
}

void mouseClicked() {

  target.x = mouseX;
  target.y = mouseY;

}