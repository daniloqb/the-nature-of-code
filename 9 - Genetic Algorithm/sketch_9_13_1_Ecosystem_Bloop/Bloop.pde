class Bloop{
 
  PVector location;
  float r;
  float maxspeed;
  float xoff,yoff;
  float health = 500;
  boolean dead = false;
  
  DNA dna;
  
  Bloop(){
    location = new PVector(random(width), random(height));
    dna = new DNA();
    init();
  }
  
 Bloop(PVector l_,DNA dna_){
    location = l_;
    dna = dna_;
    init();
 }
 
 void init(){ 
    xoff = random(1000);
    yoff = random(1000);
    r = map(dna.genes[0],0,1,8,150);
    maxspeed = map(dna.genes[0],0,1,10,0.1);
 }
  
  void update(){
    
   if (!dead){
     float vx = map(noise(xoff),0,1,-maxspeed,maxspeed);
     float vy = map(noise(yoff),0,1,-maxspeed,maxspeed);
  
     PVector velocity = new PVector(vx,vy);
     location.add(velocity);
     xoff += 0.01;
     yoff += 0.01;
   
     checkEdges();
   
     health--;
     if(health <= 0.0){
       dead = true;
     }
    }
  }
  
  boolean isDead(){
    return dead;
  }
  
  void display(){
    float alpha = map(health,0,500,0,255);
    
    fill(255,0,100,alpha);
    ellipse(location.x, location.y,r,r);
  }
  
  void checkEdges(){
   
    if (location.x < 0){
      location.x = width;
    } else if (location.x > width){
      location.x = 0;
    }
    
    if (location.y < 0){
      location.y = height;
    } else if (location.y > height){
      location.y = 0;
    }
  
  } 
  
  Bloop reproduce(float mutationRate){
   DNA childDNA = dna.copy();   
   childDNA.mutate(mutationRate);
   PVector l = location.copy();
   return new Bloop(l,childDNA);
   //return new Bloop();
  }
  
  
  
  
}