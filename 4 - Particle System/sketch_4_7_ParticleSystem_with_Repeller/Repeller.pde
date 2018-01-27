class Repeller{
  
  float mass;
  PVector location;
  float strength = 100;
  
  Repeller(PVector l){
   
    location = l.copy();
    mass = 5;
    
  }
  
  
  void display(){
   stroke(0);
   fill(255,255,0,150);
   ellipse(location.x,location.y,mass*16,mass*16);
  }
  
  PVector repel(Particle p){
  
    PVector dir = PVector.sub(location,p.location);
    float d = dir.mag();
    dir.normalize();
    float force = -1 * strength / (d*d);
    dir.mult(force);
    
    return dir;
  
  }
  
}