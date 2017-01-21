
float a = 0.0;
float aVelocity = 0.0;
float aAcceleration = 0.0;

void setup(){
  size(640,360);  
}


void draw(){
  background(255);
  
  aAcceleration = map(mouseX,0,width,-0.001,0.001);
  a += aVelocity;
  aVelocity += aAcceleration;
  
  
  
  rectMode(CENTER);
  stroke(0);
  fill(127);
  translate(width/2, height/2);
  rotate(a);
  rect(0,0,64,36);
}