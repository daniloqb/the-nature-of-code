class Food{
  
 PVector location;
 float r = 8;
 
 Food(){
  location = new PVector(random(width), random(height)); 
 }
 
 Food(PVector l_){
   location = l_;
 }
 
 void update(){
   
 }
 
 void display(){
   fill(0);
   ellipse(location.x,location.y,r,r);   
 }
  
}