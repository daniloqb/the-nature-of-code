
PVector v1,v2,center;

float r1,r2;


void setup(){
  size(800,600);
  
  r1 = 100;
  r2 = 100;
  
  v1 = PVector.random2D();
  v2 = new PVector(1,0);
  center = new PVector(width/2, height/2);
}

void draw(){
  background(255);
  
  v1.normalize();
  v2.normalize();
  pushMatrix();
  
  translate(width/2, height/2);
  
  noFill();
  stroke(0);
  line(0,0,v1.x * r1, v1.y * r1);
  stroke(255,0,0);
   line(0,0,v2.x * r2, v2.y * r2);
  popMatrix();
  
  
  float angle = PVector.angleBetween(v1,v2);
  
  fill(0);
  text("Angle Between: " + str(degrees(angle)), 10, 10, 170, 80); 
  text("Dot Product: " + str(v1.dot(v2)), 10, 30, 170, 100); 
}

void mouseClicked(){
 
  v1 = PVector.sub(new PVector(mouseX,mouseY),center);
  
}