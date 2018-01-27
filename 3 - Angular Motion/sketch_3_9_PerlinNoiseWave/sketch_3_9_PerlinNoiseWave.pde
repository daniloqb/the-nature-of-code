float start_angle = 0;

float angleVel = 0.1;
float amplitude = 100;



void setup(){
  size(640,360);
  
  
}

void draw(){

  background(255);
  stroke(0);
  strokeWeight(2);
  noFill();
 
  start_angle += 0.015;
  float angle = start_angle;  
  
  for(int x = 0; x < width; x+=1){
   
    float y = map(noise(angle),-1,1,0,height);
    
    ellipse(x*10,y,10,10);
    angle += angleVel;
  }
  



}