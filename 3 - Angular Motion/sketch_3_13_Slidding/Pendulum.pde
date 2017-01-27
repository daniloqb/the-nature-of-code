class Pendulum {

  PVector origin;
  PVector location;


  float r;
  float angle;
  float aVelocity;
  float aAcceleration;
  float ballr;

  boolean dragging = false;


  Pendulum(PVector origin_, float r_) {

    origin = origin_.get();
    location = new PVector();
    r = r_;

    angle = PI/4;

    aVelocity = 0;
    aAcceleration = 0;
    ballr = 15;
  }


  void update() {

    if (!dragging) {
      float gravity = 1;
      aAcceleration = (-1 * gravity / r) * sin(angle);

      aVelocity += aAcceleration;
        angle += aVelocity;

      aVelocity *= 0.993;
    }
  }

  void display() {

    location.set(r * sin(angle), r * cos(angle), 0);
    location.add(origin);
    stroke(0);
    line(origin.x, origin.y, location.x, location.y);
    fill(175);
    
    if (dragging){
      fill(0);
    }
    ellipse(location.x, location.y, ballr, ballr);
  }


  void go() {

    update();
    drag();
    display();
  }


  void clicked(int mx, int my) {
    float d = dist(mx,my,location.x,location.y);
    
    if (d < ballr){
     dragging = true; 
    }
  }


  void stopDragging() {
    aVelocity = 0;
    dragging = false;
  }
  
  
  void drag(){
  
    if(dragging){
      PVector diff = PVector.sub(origin, new PVector(mouseX, mouseY));
      angle = atan2(-1 *diff.y, diff.x) -radians(90);
    }
  }
}