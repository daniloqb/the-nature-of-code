Particle p;
Particle v;
//Particle loki;

ArrayList<Particle> particles;
ArrayList<Particle> targets;
ArrayList<Particle> lokis;

PVector mouse_target;

void setup() {
  size(1204, 768);
  //p = new Particle();
  //v = new Particle();
  //p.maxspeed = 8;
  //test_avoid_setup();

  //loki = new Particle( new PVector(random(width),random(height)));
  //loki.size = 10;
  //loki.maxspeed = 3;
  //loki.debug = false;

  mouse_target = new PVector(width/2, height/2);
  particles = new ArrayList<Particle>();
  lokis = new ArrayList<Particle>();

  for (int i =0; i < 20; i++) {
    lokis.add( new Particle( new PVector( random(width), random(height))));  
    lokis.get(i).size = 6;
    lokis.get(i).maxspeed = 3;
  }

  for (int i =0; i < 100; i++) {
    particles.add( new Particle( new PVector( random(width), random(height))));
  }

  targets = new ArrayList<Particle>();

  for (int i =0; i < 10; i++) {
    targets.add( new Particle(new PVector( random(width), random(height))));
    // targets.get(i).velocity.mult(0);
    targets.get(i).size = random(10, 50);
    targets.get(i).maxspeed = 0.25;
    targets.get(i).scan_radius = 2* targets.get(i).size;
  }
}

void draw() {
  background(0); 
  frameRate(30);
  //test_avoid();

  //p.run();
  //v.run();

  test_complex_02();

  //loki_test();
}

//void loki_test(){

// loki.apply_force(loki.wander());
//for(Particle t: targets){
//  PVector avoid_force = loki.avoid(t.position, t.size);
//  loki.apply_force(avoid_force);
//  }
//loki.run(); 

//}

void test_complex_02() {
  for (Particle p : particles) {
    p.apply_behaviors(particles);
    for (Particle t : targets) {
      PVector avoid_force = p.avoid(t.position, t.size);
      p.apply_force(avoid_force);
    }
    for (Particle l : lokis) {
      PVector flee_force = p.flee(l, true);
      flee_force.mult(2);
      p.apply_force(flee_force);
    }
    //PVector flee_force = p.flee(loki,true);
    //flee_force.mult(2);
    //p.apply_force(flee_force);
    p.run();
  }

  for (Particle t : targets) {
    PVector sep = t.separate(targets);
    t.apply_force(sep);
    t.boundaries_pass();
    t.update();
    t.display02();
  }

  for (Particle l : lokis) {
    l.apply_behaviors(lokis);
    for (Particle t : targets) {
      PVector avoid_force = l.avoid(t.position, t.size);
      l.apply_force(avoid_force);
    }
    l.run();
  }
}

void test_complex_01() {
  for (Particle p : particles) {
    p.apply_behaviors(particles);
    PVector force = p.avoid(mouse_target, 50);
    p.apply_force(force);
    p.run();
  }

  show_mouse_target();
}

void test_avoid_setup() {

  p = new Particle(new PVector(0, height/2));
  v = new Particle(new PVector(0, 30));


  p.col = color(255, 0, 0);
  p.maxspeed = 4;

  mouse_target = new PVector(width/2, height/2);
}
void test_avoid() {
  //PVector force = p.avoid(mouse_target);
  PVector seek_force = p.seek(v, false);
  //p.apply_force(force);
  p.apply_force(seek_force);
}


void test_rendezvou_setup() {
  v = new Particle(new PVector(0, 30));
  p = new Particle(new PVector(100, height - 100));

  v.velocity = new PVector(4, 1);
  p.velocity = new PVector(0, 0);

  p.col = color(255, 0, 0);
  v.col = color(255, 255, 255);
  p.maxspeed = 4;
}
void test_rendezvou() {
  PVector force = p.rendezvou(v, false);
  p.apply_force(force);
}

void test_evade_setup() {
  v = new Particle(new PVector(0, 0));
  p = new Particle(new PVector(width/2, height/2));

  v.velocity = new PVector(4, 2.5);
  p.velocity = new PVector(0, 0);

  p.col = color(255, 0, 0);
  v.col = color(255, 255, 255);
  p.maxspeed = 4;
}
void test_evade() {
  PVector force = p.evade(v, true);
  p.apply_force(force);
}



void test_pursuit_setup() {
  v = new Particle(new PVector(0, 30));
  p = new Particle(new PVector(100, height - 100));

  v.velocity = new PVector(4, 1);
  p.velocity = new PVector(0, 0);

  p.col = color(255, 0, 0);
  v.col = color(255, 255, 255);
  p.maxspeed = 4;
}
void test_pursuit() {
  PVector force = p.pursuit(v, false);
  p.apply_force(force);
}


void show_mouse_target() {

  noFill();
  ellipseMode(RADIUS);

  stroke(255, 0, 255);
  ellipse(mouse_target.x, mouse_target.y, 50, 50);
}

void mouseClicked() {

  for (int i = 0; i < 100; i++) 
    particles.add(new Particle(new PVector(mouseX, mouseY)));
}

//void mouseClicked(){

//  v.position.x = mouseX;
//  v.position.y = mouseY;

//}

//void mouseClicked(){

//  mouse_target.x = mouseX;
//  mouse_target.y = mouseY;

//}