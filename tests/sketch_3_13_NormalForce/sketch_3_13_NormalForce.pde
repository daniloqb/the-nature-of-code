
float angle = 0;
//float gravity = 0.4;

PVector position;
PVector gravity;
PVector normal;
PVector pendulum;

void setup(){

  size(640,360);
  position = new PVector(width/2, height/2);
  gravity = new PVector(0,50);
  pendulum = new PVector();
  normal = new PVector();

  

}



void draw(){

   background(255);
   float mag = gravity.mag();
   pendulum.set(mag * sin(angle), mag * cos(angle),0);
   normal.set(mag * sin(angle + (PI/2)), mag * cos(angle + (PI/2)),0);
   
   stroke(0);
   pushMatrix();
   translate(position.x,position.y);
   line(0,0,gravity.x,gravity.y);
   line(0,0, pendulum.x, pendulum.y);
   line(0,0,normal.x,normal.y);
   popMatrix();
   
   angle += 0.001;

}