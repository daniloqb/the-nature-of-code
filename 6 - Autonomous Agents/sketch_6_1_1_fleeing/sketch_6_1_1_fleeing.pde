Vehicle vehicle;
Vehicle seek;
Vehicle flee;

void setup(){
  size(800,600);
  seek  = new Vehicle(random(width), random(height));
  flee  = new Vehicle(random(width), random(height));

  vehicle = new Vehicle(width/2, height/2);
  
  seek.col = color(0,255,40);
  flee.col = color(255,0,0);

}

void draw(){
   background(0);

   seek.update();
   flee.update();
   vehicle.update();
   vehicle.seek(seek.location);
   vehicle.flee(flee.location);
   
   
   seek.display();
   flee.display();
   vehicle.display();
}

void mouseClicked() {

}