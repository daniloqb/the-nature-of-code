class Walker{
 int x;
 int y;
 
 Walker(){
   x = width / 2;
   y = height / 2;
 }
 
 void step(int targetX, int targetY){

   float choice = random(1);
   
   if (choice < 0.5){
    if (x < targetX){
      x++;
    }
    else{
      x--;
    }
    
    if(y < targetY){
      y++;
    }
    else{
      y--;
    }
      
   }
   else if(choice < 0.6){
     x++;
   }
   else if(choice < 0.7){
    x--;
   }
   else if (choice < 0.8){
     y++;
   }
   else if(choice < 0.9){
     y--;
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
  w.step(mouseX, mouseY);
  w.display();
  
}