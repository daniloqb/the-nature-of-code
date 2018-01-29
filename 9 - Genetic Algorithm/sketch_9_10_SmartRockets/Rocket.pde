class Rocket{
  
  DNA dna;
  float fitness;
  int geneCounter = 0;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  int size = 16;
  
  Rocket(){
    dna = new DNA();
    location = new PVector(0,height);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);

  }
  Rocket(DNA d){
    dna = d;
    location = new PVector(0,height);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);

  }
  
  void applyForce(PVector f){
    
   acceleration.add(f); 
  }
  
  void update(){
   velocity.add(acceleration);
   location.add(velocity);
   acceleration.mult(0);
    
  }
  
  void display(){
   stroke(0);
   fill(175,150);
   ellipse(location.x,location.y,size,size);
  }
  
  void run(){
   
    applyForce(dna.genes[geneCounter]);
    geneCounter++;
    update();
    display();
  }
  
  void fitness(PVector target){
   float d = PVector.dist(location,target);
   
   fitness = 1/d;
  } 
  
}