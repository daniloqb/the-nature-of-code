class Oscillator{
 
  PVector angle;
  PVector velocity;
  PVector amplitude;
  
  
  Oscillator(){
   angle = new PVector();
   velocity = new PVector(random(-0.05,0.05),random(-0.05,0.05));
   amplitude = new PVector(width/2, height/2);
  }
  
  
 void oscillate(){
  angle.add(velocity); 
 }
 
 void display(){
  
   float x = sin(angle.x) * amplitude.x;
   float y = sin(angle.y) * amplitude.y;
   
   
   pushMatrix();
   translate(width/2, height/2);
   stroke(0);
   fill(175,80);
   
   line(0,0,x,y);
   ellipse(x,y,10,10);
   
   popMatrix();
 }
  
}



Oscillator oscillator;

void setup(){

  size(640,360);
  
  oscillator = new Oscillator();

}



void draw(){

  background(255);
  oscillator.oscillate();
  oscillator.display();


}