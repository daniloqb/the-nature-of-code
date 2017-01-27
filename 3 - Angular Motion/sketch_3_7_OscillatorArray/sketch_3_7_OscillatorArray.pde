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



Oscillator[] oscillators;

void setup(){

  size(640,360);
  
  oscillators = new Oscillator[5];

  for(int i = 0; i < 5; i++){
  
     oscillators[i] = new Oscillator();
  
  }

}



void draw(){


  
  for(Oscillator oscillator: oscillators){
  
    oscillator.oscillate();
    oscillator.display();
  }

}