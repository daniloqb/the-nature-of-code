ParticleSystem ps;
PImage img;

void setup(){
  size(600,360);
  img = loadImage("texture.png");
  ps = new ParticleSystem( new PVector(width/2, 50),img);
  
}


void draw(){
  blendMode(ADD);
   background(0);    
   PVector gravity = new PVector(0,0.01);
   

  ps.addParticle();
  ps.applyForce(gravity);
  ps.run();
 
 }