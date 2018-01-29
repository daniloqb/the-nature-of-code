class Rocket{
  
  DNA dna;
  float fitness;
  int geneCounter = 0;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  int size = 16;
  boolean completed;
  boolean crashed;
  color c1;
  
  Rocket(){
    dna = new DNA();
    location = new PVector(0 + size * 2,height - size * 2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    crashed = false;
    completed = false;
    c1 = color(175,150);
  }
  Rocket(DNA d){
    dna = d;
    location = new PVector(0 + size * 2,height - size * 2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    crashed = false;
    completed = false;
    c1 = color(175,150);  
}
  
  void applyForce(PVector f){
    
   acceleration.add(f); 
  }
  
  void update(){
    checkEdges();
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    
  }
  
  void display(){
   stroke(0);
   fill(c1);
   ellipse(location.x,location.y,size,size);
  }
  
  void run(){
   if (!crashed && !completed){
    applyForce(dna.genes[geneCounter]);
    geneCounter++;
    update();
   }
   display();
  }
  
  void checkEdges(){
   if (location.x <= 0){
     location.x = size/2;
     crashed = true;
     c1 = color(255,0,0);
   }else if (location.x >= width){
     crashed = true;
     location.x = width - size;
     c1 = color(255,0,0);
   }
  
  if (location.y <= 0){
    crashed = true;
    location.y = size/2;
    c1 = color(255,0,0);
  } else if (location.y > height){
    crashed = true;
    location.y = height - size/2;
    c1 = color(255,0,0);
  }
}
  
  void fitness(PVector target){
   float d = PVector.dist(location,target);
   
   fitness = 1/d;
   
   if (completed){
     fitness *= 10;
   }
   if (crashed){
     fitness /= 10;
     
   }
  }
}