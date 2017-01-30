class Spaceship {

  ParticleSystem ps;


  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;

  float angle;


  Spaceship(PVector l) {


    location = l.copy();
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    topspeed = 5;

    angle = 0;

    ps = new ParticleSystem(location.copy());
  }


  void trust() {


    float x = cos(ship.angle) * 0.01;
    float y = sin(ship.angle) * 0.01;

    ship.acceleration.add(new PVector(x, y));
  }

  void turnLeft() {
    ship.angle -=0.15;
  }


  void turnRight() {

    ship.angle +=0.15;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity); 

    ps.applyForce(PVector.mult(velocity,-1));
    ps.origin.x = location.x;
    ps.origin.y = location.y;
    ps.addParticle();
    ps.run();

    velocity.mult(0.99);
  }

  void display() {
    stroke(0);
    fill(175);

    pushMatrix();   
    translate(location.x, location.y);
    rotate(angle);
    //rect(0,0,16,16);
    beginShape(TRIANGLES);
    vertex(-10, -10);
    vertex(-10, 10);
    vertex(10, 0);
    endShape();
    popMatrix();
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }


  void run() {

    ship.update();
    ship.checkEdges();
    ship.display();
  }
}