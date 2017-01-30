Spaceship ship;



void setup(){
  size(600,360);
  
  ship = new Spaceship(new PVector(width/2,height/2));

}


void draw(){
   background(255);


  ship.run();


 
 }
 







void keyPressed() {
  PVector vel;
  if (key == CODED) {
    if (keyCode == UP) {
      ship.trust();
    } 
    
    /*
    else if (keyCode == DOWN) {
      
      float x = cos(ship.angle) * -0.01;
      float y = sin(ship.angle) * -0.01;
           
      ship.acceleration.add(new PVector(x,y));

    } 
    */
     else if (keyCode == LEFT) {
      
      ship.turnLeft();

    } 
     else if (keyCode == RIGHT) {
      
      ship.turnRight();

    } 
  } 
}

void keyReleased(){
 ship.acceleration.mult(0); 

}