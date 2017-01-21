class Attractor{
  
  float mass;
  PVector location;
  float G;
  
  Attractor(float m, float x, float y){
   
    location = new PVector(x,y);
    mass = m;
    G = 1;
    
  }
  
  
  PVector attract(Mover m){
   
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance,5,25);
    
    force.normalize();
    
    float strength = (G * mass * m.mass)/(distance * distance);
 
    force.mult(strength);
       
    
    return force;
    
  }
  
  
  void display(){
   stroke(0);
   fill(255,255,0,150);
   ellipse(location.x,location.y,mass*2,mass*2);
  }
}


class Mover{
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float mass;
  
  
  Mover(float m, float x, float y){
   
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 5;
    mass = m;
  }
  
  void update(){
   velocity.add(acceleration);
   velocity.limit(topspeed);
   location.add(velocity); 

    acceleration.mult(0);
  }
  
  void display(){
   stroke(0);
   fill(175,150);
   ellipse(location.x,location.y,mass*16,mass*16);
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
    
  }
  
  void checkEdges(){
   if (location.x > width){
     location.x = width;
     velocity.x *= -1;
   }
   else if(location.x < 0){
     location.x = 0;
     velocity.x *= -1;
   }
   
   if (location.y > height){
     location.y = height;
     velocity.y *= -1;
   }
   else if(location.y < 0){
     location.y = 0;
     velocity.y *= -1;
   }
  }
}




Attractor[] attractors;
Mover[] movers;



void setup(){
  size(800,600);
  attractors = new Attractor[2];
  
  for (int i = 0; i < attractors.length; i++){
   attractors[i] = new Attractor(random(20,25),random(width), random(height)); 
  }
  
  movers = new Mover[5];
  
  for (int i = 0; i < movers.length; i++){
  
  movers[i] = new Mover(random(1,3),random(width),random(height));
  
  
  
  }
}


void draw(){
 
  
  background(255);
  
  
  for (Attractor a: attractors){
  
    for (Mover m: movers){
      m.applyForce(a.attract(m));
  
      m.update();
      //m.checkEdges();
      m.display();
  }
  
  a.display();
  
  }

}




void mouseDragged() {

   for (Attractor a: attractors){
      float sizeA = a.mass * 5;
      if((mouseX >= a.location.x - sizeA)&&(mouseX <= a.location.x + sizeA)){
        if((mouseY >= a.location.y - sizeA)&&(mouseY <= a.location.y + sizeA)){
          a.location.x = mouseX;
          a.location.y = mouseY;
      }
    }
  }
}