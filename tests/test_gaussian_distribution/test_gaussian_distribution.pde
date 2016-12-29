import java.util.Random;

Random generator;


void setup(){

size(400,300);

generator = new Random();

}



void draw(){

  
  float mean = 10;
  float deviation = 3;
  
  background(255);
  fill(0);
  float h = (float) generator.nextGaussian();
  h *= deviation;
  h += mean;
  ellipse(width/2, height/2, h,h);
}