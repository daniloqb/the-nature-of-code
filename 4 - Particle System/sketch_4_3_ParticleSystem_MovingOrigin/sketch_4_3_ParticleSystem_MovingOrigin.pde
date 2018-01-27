ParticleSystem ps;

void setup(){
  size(600,360);
  ps = new ParticleSystem( new PVector(width/2, 50));
}


void draw(){
   background(255);

  ps.addParticle();
  ps.run();
 
 }
 
 
 
 void mouseClicked() {
  ps.origin.x = mouseX;
  ps.origin.y = mouseY;
}