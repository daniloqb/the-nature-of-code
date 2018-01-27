import java.util.Iterator;

class ParticleSystem{

  ArrayList<Particle> particles;
  PVector gravity;
  PVector origin;


  ParticleSystem(PVector o){
  
    origin = o.copy();
    particles = new ArrayList<Particle>();
    gravity = new PVector(0,0.01);

  }
  
  void addParticle(){
      float r = random(1);
      
      if(r < 0.5){
       particles.add(new Particle(origin));
       
      }
      else{
      particles.add(new SquareParticle(origin));
      }

  }
  
  void run(){
  
  
  Iterator<Particle> it = particles.iterator();
  
  while (it.hasNext()){
   Particle p = it.next();
   p.applyForce(gravity);
   p.run();
   
   if (p.isDead()){
    it.remove(); 
   }
  
  
  }

  }

}