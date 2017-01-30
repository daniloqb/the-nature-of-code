class SquareParticle extends Particle{


  SquareParticle(PVector l){
      super(l);  
  }
  
  void display(){
   stroke(0,lifespan);
   fill(175,lifespan);
   rectMode(CENTER);
   pushMatrix();
   translate(location.x, location.y);
   rotate(angle);
   //line(0,0,10,10);
   
   rect(0,0,10,10);
   popMatrix();
  }


}