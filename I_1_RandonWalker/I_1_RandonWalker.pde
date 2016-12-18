class Walker{
 int x;
 int y;
 
 Walker(){
   x = width / 2;
   y = height / 2;
 }
 
 void step(){

   int choice = int(random(4));
   
   switch(choice){
     case 0:
       x++;
     break;
     case 1:
       x--;
     break;
     case 2:
       y++;
     break;
     case 3:
       y--;
     break;
   
   }
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