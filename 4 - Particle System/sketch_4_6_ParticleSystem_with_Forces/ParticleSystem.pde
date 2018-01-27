import java.util.Iterator;

class ParticleSystem{

  ArrayList<Particle> particles;
  PVector origin;


  ParticleSystem(PVector o){
  
    origin = o.copy();
    particles = new ArrayList<Particle>();


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