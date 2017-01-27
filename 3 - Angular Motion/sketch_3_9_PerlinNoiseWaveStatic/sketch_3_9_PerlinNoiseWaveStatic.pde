float angle = 0;
float angleVel = 0.01;
float amplitude = 100;



void setup(){
  size(640,360);
  
  background(255);
  stroke(0);
  strokeWeight(2);
  noFill();
  
  beginShape();
  for(int x = 0; x < width; x+=1){
   
    float y = map(noise(angle),-1,1,0,height);
    
    vertex(x,y);
    angle += angleVel;
  }
  
  endShape();
  
 
  
}