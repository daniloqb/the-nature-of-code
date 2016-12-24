class Walker{
 int x;
 int y;
 
 Walker(){
   x = width / 2;
   y = height / 2;
 }
 
 void step(){

   int step_x = int(random(3))-1;
   int step_y = int(random(3))-1;
   
   x += step_x;
   y += step_y;
   
   
   
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