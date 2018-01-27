import java.util.Iterator;

class ParticleSystem{

  ArrayList<Particle> particles;
  PVector origin;
  PImage img;


  ParticleSystem(PVector o, PImage img_){
  
    origin = o.copy();
    particles = new ArrayList<Particle>();
    img = img_;


  }
    ParticleSystem(PVector o){
  
    origin = o.copy();
    particles = new ArrayList<Particle>();


  }
  
  void addParticle(){

       particles.add(new ImgParticle(origin,img));


  }
  
  void applyForce(PVector force){
  
    for(Particle p: particles){
      p.applyForce(force);
    }
  }
  
  void run(){
  
  
  Iterator<Particle> it = particles.iterator();
  
  while (it.hasNext()){
   Particle p = it.next();
   p.run();
   
   if (p.isDead()){
    it.remove(); 
   }
  
  
  }

  }

}