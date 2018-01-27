
Ball ball;

void setup(){
  size(600,360);
  background(255);
  
  ball = new Ball();
}


void draw(){

  background(255);
  
  ball.move();
  ball.display();



}