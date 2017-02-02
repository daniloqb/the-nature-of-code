ParticleSystem ps;
Repeller r;

void setup(){
  size(600,360);
  ps = new ParticleSystem( new PVector(width/2, 50));
  r = new Repeller(new PVector(width/2 - 20, height/2));
}


void draw(){
   background(255);    
   PVector gravity = new PVector(0,0.01);
   

  ps.addParticle();
  ps.applyForce(gravity);
  ps.applyRepel(r);
  ps.run();
  r.display();
 
 }