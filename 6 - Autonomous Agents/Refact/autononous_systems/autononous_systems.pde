Particle p;
Particle v;

PVector mouse_target;

void setup(){
  size(1204,768);
  //p = new Particle();
  //v = new Particle();
  //p.maxspeed = 8;
  test_avoid_setup();
}

void draw(){
 background(0); 
 frameRate(30);
 test_avoid();
 
 p.run();
 v.run();
}

void test_avoid_setup(){

  p = new Particle(new PVector(0,height/2));
  v = new Particle(new PVector(0,30));

 
  p.col = color(255,0,0);
  p.maxspeed = 4;
  
  mouse_target = new PVector(width/2, height/2);
  
}
void test_avoid(){
 PVector force = p.avoid(mouse_target);
 p.apply_force(force);
}


void test_rendezvou_setup(){
  v = new Particle(new PVector(0,30));
  p = new Particle(new PVector(100,height - 100));
  
  v.velocity = new PVector(4,1);
  p.velocity = new PVector(0,0);
  
  p.col = color(255,0,0);
  v.col = color(255,255,255);
  p.maxspeed = 4;
}
void test_rendezvou(){
 PVector force = p.rendezvou(v,false);
 p.apply_force(force);
}

void test_evade_setup(){
  v = new Particle(new PVector(0,0));
  p = new Particle(new PVector(width/2,height/2));
  
  v.velocity = new PVector(4,2.5);
  p.velocity = new PVector(0,0);
  
  p.col = color(255,0,0);
  v.col = color(255,255,255);
  p.maxspeed = 4;
}
void test_evade(){
 PVector force = p.evade(v,true);
 p.apply_force(force);
}



void test_pursuit_setup(){
  v = new Particle(new PVector(0,30));
  p = new Particle(new PVector(100,height - 100));
  
  v.velocity = new PVector(4,1);
  p.velocity = new PVector(0,0);
  
  p.col = color(255,0,0);
  v.col = color(255,255,255);
  p.maxspeed = 4;
}
void test_pursuit(){
 PVector force = p.pursuit(v,false);
 p.apply_force(force);
}

//void mouseClicked(){
 
//  v.position.x = mouseX;
//  v.position.y = mouseY;
  
//}
void mouseClicked(){
 
  mouse_target.x = mouseX;
  mouse_target.y = mouseY;
  
}