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
   
   float stepsize = montecarlo();
   
   xstep = random(-stepsize,stepsize);
   ystep = random(-stepsize,stepsize);
   
   x += xstep;
   y += ystep;
   
    
 }
 
 void display(){
   stroke(0);
   point(x,y);
 }
 
 float montecarlo(){
   
   while(true){
    
     float r1 =random(1);
     
     float probability = r1;
     
     float r2 = random(1);
     
     if (r2 < probability){
       return r1;
     }
   }
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