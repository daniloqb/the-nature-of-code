import java.util.*;

Random generator;


void setup(){
 
  size(640,360);
  generator = new Random();
}


void draw(){
  
  float num_x = (float) generator.nextGaussian();
  float num_y = (float) generator.nextGaussian();

  float sd= 60;
  float mean_x = 320;
  float mean_y = 180;
  
  float x = sd * num_x + mean_x;
  float y = sd * num_y + mean_y;
  
  noStroke();
  fill(255,10);
  ellipse(x,y,16,16);
}