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
  
   float xstep, ystep;
   
  float r = random(1);
  
  if (r < 0.01){
    xstep = random(-100,100);
    ystep = random(-100,100);
  }
  else{
    xstep = random(-1,1);
    ystep = random(-1,1);
  }
   
   x += xstep;
   y += ystep;
   
    
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