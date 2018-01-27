import java.util.Iterator;

class ParticleSystem {

  ArrayList<Particle> particles;

  PVector origin;
  PVector force;


  ParticleSystem(PVector o) {

    origin = o.copy();
    particles = new ArrayList<Particle>();

    force = new PVector(0, 0.0);
  }
  
  void applyForce(PVector f){
  
    force = (f.copy());
  
  }


  void addParticle() {

    Particle p = new Particle(origin.copy());
    p.applyForce(force);
    if(force.mag() > 0.05){
      p.applyForce(new PVector(random(-0.5,0.5),random(-0.5,0.5)));
    }
    particles.add(p);
  }


  void run() {

    Iterator<Particle> it = particles.iterator();

    while (it.hasNext()) {
      Particle p = it.next();
      p.run();

      if (p.isDead()) {
        it.remove();
      }
    }
  }
}