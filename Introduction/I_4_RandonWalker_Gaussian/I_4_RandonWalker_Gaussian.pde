import java.util.*;


class Walker{
 float x;
 float y;
 Random generator;
 
 Walker(){
   x = width / 2;
   y = height / 2;
   
   generator = new Random();
 }
 
 void step(){
  
   float num_x = (float) generator.nextGaussian();
   float num_y = (float) generator.nextGaussian();
   
   
   x += num_x;
   y += num_y;
   
    
 }
 
 void display(){
   stroke(0);
   point(x,y);
 }
}


Walker w;


void setup(){
  size(800,600);
  w = new Walker();
}


void draw(){
  w.step();
  w.display();
  
}