class Walker{
 int x;
 int y;
 
 Walker(){
   x = width / 2;
   y = height / 2;
 }
 
 void step(){

   float choice = random(1);
   
   if (choice < 0.4){
     x++;
   }
   else if(choice < 0.6){
     x--;
   }
   else if(choice < 0.8){
     y++;
   }
   else{
     y --;
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