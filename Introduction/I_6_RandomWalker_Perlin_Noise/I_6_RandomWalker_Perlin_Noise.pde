import java.util.*;


class Walker{
 float x;
 float y;
 float tx,ty;
 Random generator;
 
 Walker(){
   x = width / 2;
   y = height / 2;
 
   tx = 0;
   ty = 10000;
   generator = new Random();
 }
 
 void step(){
  

   x = map(noise(tx),0,1,0,width);
   y = map(noise(ty),0,1,0,height);
   
   tx += 0.01;
   ty += 0.01;
   
   
    
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