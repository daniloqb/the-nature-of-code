


float amplitude = 100;
float start_angle = 0.0;
float angle_vel = 0.23;

void setup(){

  size(640,360);


}


void draw(){

  background(255);
  translate(5, height/2);

  fill(127,80);
  stroke(0);
  
  start_angle += 0.015;
  float angle = start_angle;
  
  for(int i = 0; i < 64; i++){
    
    float y = amplitude * sin(angle);
   
    
    ellipse(i*10,y,10,10);
    angle += angle_vel;
  
  }

}