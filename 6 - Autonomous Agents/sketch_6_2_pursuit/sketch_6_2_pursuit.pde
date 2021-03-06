Vehicle vehicle;
Vehicle seek;
Vehicle flee;
Vehicle pursuit;
Vehicle evasion;
Vehicle arrive;
Vehicle avoid;
Vehicle wander;



PVector mouse_target = new PVector(mouseX, mouseY);

void setup(){
  size(1024,768);
  arrive  = new Vehicle(random(width), random(height));
  seek  = new Vehicle(random(width), random(height));
  flee  = new Vehicle(random(width), random(height));
  pursuit  = new Vehicle(width/2, height/2);
  evasion  = new Vehicle(width/2, height/2);
  vehicle = new Vehicle(width/2, height/2);
  avoid = new Vehicle(width/2, height/2);
  wander = new Vehicle(width/2, height/2);

  arrive.col = color(255,60,0);
  seek.col = color(0,255,40);
  flee.col = color(255,0,0);
  pursuit.col = color(255,255,255);
  evasion.col = color(255,255,60);
  avoid.col = color(0,120,255);
  wander.col = color(100,100,100);
  
  arrive.max_speed = 14;
  avoid.max_speed = 14;
  avoid.max_force = 0.5;
  //wander.max_speed = 6;
  
  


}

void draw(){
   background(0);
      
      
   noFill();
   stroke(255,0,0);
   float r = 0.5 * ((arrive.max_speed*arrive.max_speed)/arrive.max_force);
   //float r = 40;
   ellipse(mouse_target.x, mouse_target.y,r,r);

   pursuit.pursuit(seek);
   pursuit.avoid(mouse_target,r,40);
   vehicle.seek(seek.location);
   vehicle.flee(flee.location);
   evasion.evade(flee);
   evasion.pursuit(seek);
  
   //arrive.arrive(flee.location);
   avoid.avoid(mouse_target,r,40);
   arrive.arrive(mouse_target);
   wander.wander();
   
   
   vehicle.update();
   seek.update();
   flee.update();
   evasion.update();
   pursuit.update();
   arrive.update();
   avoid.update();
   wander.update();

     
   seek.display();
   flee.display();
   pursuit.display();
   evasion.display();
   vehicle.display();
   arrive.display();
   avoid.display();
   wander.display();
   

   

}

void mouseClicked() {
  mouse_target.x = mouseX;
  mouse_target.y = mouseY;
}