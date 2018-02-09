class Particle {
  int type;
  PVector position;
  PVector velocity;
  PVector acceleration;
  color col;
  float size;
  float lifetime;
  float age;
  float transparency;  
  float maxspeed;
  float maxforce;

  int mode;
  float safe_radius;
  float scan_radius;
  boolean scan_on;
  float wander_angle;

  boolean debug;

  Particle() {
    position = new PVector(random(width), random(height));
    init();
  }

  Particle(PVector p) {
    position = p.copy();
    init();
  }

  void init() {
    type = 0;
    maxspeed = 4;
    maxforce = 0.15;
    velocity = PVector.random2D();
    velocity.mult(maxspeed);
    acceleration = new PVector(0, 0);

    transparency = 255;
    col = color(random(255), random(255), random(255), transparency);

    size = 3;
    age = 0;
    lifetime = 255;

    mode = 0;

    safe_radius = pow(size, 3);
    scan_radius = 50;
    scan_on = false;
    wander_angle = 0;

    debug = false;
  }

  void run() {
boundaries_pass();
    update();
    display();
    
  }

  /*
* APPLY A FORCE TO PARTICLE
   */

  void apply_force(PVector force) {
    acceleration.add(force);
    //  acceleration.limit(maxforce);
  }

  /*
  * APPLY COMBINED FORCES TO PARTICLE
   */

  void apply_behaviors(ArrayList<Particle> particles) {

    PVector align_force = align(particles);
    PVector separate_force = separate(particles);
    PVector cohesion_force = cohesion(particles);

    align_force.mult(0.5);
    separate_force.mult(1.5);
    cohesion_force.mult(0.5);

    apply_force(align_force);
    apply_force(separate_force);
    apply_force(cohesion_force);

    
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
   // display_scan();
  }

  void display() {
    float angle = velocity.heading() +PI/2;  
    fill(col);
    noStroke();

    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    beginShape();
    vertex(0, -size*2);
    vertex(-size, size*2);
    vertex(size, size*2);
    endShape(CLOSE);
    //   ellipse(0, 0, size*2, size*2);

    popMatrix();
  }
    void display02() {
    float angle = velocity.heading() +PI/2;  
    fill(col);
    noStroke();

    pushMatrix();
    translate(position.x, position.y);
    //rotate(angle);
    //beginShape();
    //vertex(0, -size*2);
    //vertex(-size, size*2);
    //vertex(size, size*2);
    //endShape(CLOSE);
    ellipse(0, 0, size*2, size*2);

    popMatrix();
  }

  void display_scan() {
    stroke(255, 255, 0, 100);
    noFill();
    pushMatrix();
    translate(position.x, position.y);
    ellipseMode(RADIUS);
    ellipse(0, 0, scan_radius, scan_radius);
    popMatrix();
  }

  void boundaries_pass() {

    if (position.x < 0) {
      position.x =  width;
    } else if (position.x > width) {
      position.x = 0;
    }
    if (position.y < 0) {
      position.y =  height;
    } else if (position.y > height) {
      position.y = 0;
    }
  }


  /*
*  STEERING BEHAVIORS
   */

  // PRINCIPAL FUNCTION STEER
  PVector steer(PVector position_, PVector target_, PVector velocity_) {

    PVector desired = PVector.sub(target_, position_);
    desired.setMag(maxspeed);

    PVector steer = PVector.sub(desired, velocity_);
    steer.setMag(maxforce);

    return steer;
  }

  /*
  * SEEK A TARGET OR A POSITION
   *
   */
  PVector seek(Particle target, boolean scan) {
    if (scan) {
      float dist = PVector.dist(position, target.position);
      if (dist > scan_radius) {
        return new PVector(0, 0);
      }
    }    
    PVector force = steer(position, target.position, velocity);
    return force;
  }

  PVector seek(PVector target, boolean scan) {
    if (scan) {
      float dist = PVector.dist(position, target);
      if (dist > scan_radius) {
        return new PVector(0, 0);
      }
    }

    PVector force = steer(position, target, velocity);
    return force;
  }

  /*
  * FLEE FROM A PARTICLE OR A POSITION
   */

  PVector flee(Particle target, boolean scan) {

    if (scan) {
      float dist = PVector.dist(position, target.position);
      if (dist > scan_radius) {
        return new PVector(0, 0);
      }
    }

    PVector force = steer(position, target.position, velocity);
    force.mult(-1);
    return force;
  }

  PVector flee(PVector target, boolean scan) {

    if (scan) {
      float dist = PVector.dist(position, target);
      if (dist > scan_radius) {
        return new PVector(0, 0);
      }
    }
    PVector force = steer(position, target, velocity);
    force.mult(-1);
    return force;
  }

  /*
  * RANDOM WALK
   */
  PVector wander() {

    // float act = velocity.mag();    
    // float sight = 0.5*((act*act)/max_force);
    ////float sight = 100;

    PVector current_speed = velocity.copy();

    current_speed.normalize().mult(scan_radius);
    current_speed.add(position);


    if (random(1) < 0.01) {
      wander_angle = random(-PI, PI);
    }

    float vx = cos(wander_angle) * scan_radius;
    float vy = sin(wander_angle) * scan_radius;

    PVector future = new PVector(vx, vy);
    future.add(current_speed);
    //return seek(future); 
    if (debug) {
      noFill();
      stroke(255);
      strokeWeight(1);
      line(position.x, position.y, current_speed.x, current_speed.y);
      line(current_speed.x, current_speed.y, future.x, future.y);
      ellipseMode(RADIUS);
      ellipse(current_speed.x, current_speed.y, scan_radius, scan_radius);
    }
    //apply_force(seek(future));
    return seek(future, false);
    
    
}

  /*
  *   ARRIVE BEHAVIOR
   */

  PVector arrive(PVector target, boolean scan) {

    float distance;
    float slowing_distance;
    float clipped_speed;

    slowing_distance = 0.5*((maxspeed*maxspeed)/maxforce);
    clipped_speed = maxspeed;

    if (scan) {
      float dist = PVector.dist(position, target);
      if (dist > scan_radius) {
        return new PVector(0, 0);
      }
    }

    PVector desired = PVector.sub(target, position);
    distance = desired.mag();

    if (distance < slowing_distance) {
      clipped_speed = map(distance, slowing_distance, 0, maxspeed, 0);
    } 

    // This part is the steer funcion.
    desired.setMag(clipped_speed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  PVector arrive(Particle target, boolean scan) {

    float distance;
    float slowing_distance;
    float clipped_speed;

    slowing_distance = 0.5*((maxspeed*maxspeed)/maxforce);
    clipped_speed = maxspeed;

    if (scan) {
      float dist = PVector.dist(position, target.position);
      if (dist > scan_radius) {
        return new PVector(0, 0);
      }
    }

    PVector desired = PVector.sub(target.position, position);
    distance = desired.mag();

    if (distance < slowing_distance) {
      clipped_speed = map(distance, slowing_distance, 0, maxspeed, 0);
    } 

    // This part is the steer funcion.
    desired.setMag(clipped_speed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  /*
  * PURSUIT BEHAVIOR
   */

  PVector pursuit(Particle target, boolean scan) {

    PVector distance = PVector.sub(target.position, position);
    float d = distance.mag();  
    PVector dif = PVector.sub(velocity, target.velocity);
    float factor = d/dif.mag();
    //float factor = d/velocity.mag();


    PVector future_location = target.velocity.copy();    
    future_location.mult(factor);
    future_location.add(target.position);

    return seek(future_location, scan);
  }

  /*
  * EVADE BEHAVIOR
   */

  PVector evade(Particle target, boolean scan) {

    PVector distance = PVector.sub(target.position, position);
    float d = distance.mag();  
    PVector dif = PVector.sub(velocity, target.velocity);
    float factor = d/dif.mag();
    //float factor = d/velocity.mag();


    PVector future_location = target.velocity.copy();    
    future_location.mult(factor);
    future_location.add(target.position);

    return flee(future_location, scan);
  }


  PVector rendezvou(Particle target, boolean scan) {

    PVector distance = PVector.sub(target.position, position);
    float d = distance.mag();  
    // PVector dif = PVector.sub(velocity,target_velocity);
    PVector dif = PVector.sub(target.velocity, velocity);
    dif.normalize();
    // float factor = d/dif.mag();

    float factor = d;
    dif.mult(factor);

    PVector future_location = target.velocity.copy();    
    //future_location.mult(factor);
    future_location.add(dif);
    future_location.add(target.position);

    return seek(future_location, scan);
  }

  /*
  *  AVOID BEHAVIOR
   */

  PVector avoid(PVector target, float rad) {

    float current_speed = velocity.mag();
    // float lookahead = 40;
    //float lookahead = max_speed;
    float lookahead = 0.5*((current_speed*current_speed)/maxforce);

    PVector ahead = velocity.copy().normalize();
    ahead.mult(lookahead);
    ahead.add(position);

    PVector distance = PVector.sub(target, ahead);
    float d_mag = distance.mag();
    float r1 = safe_radius;
    float r2 = rad;
    float threshold = r1 + r2;
    float diff = threshold - d_mag;

    if (debug) {
      noFill();
      ellipseMode(CENTER);
      stroke(255, 255, 0);
      ellipse(position.x, position.y, r1*2, r1*2);
      stroke(255, 0, 255);
      ellipse(target.x, target.y, r2*2, r2*2);
      stroke(255);
      line(position.x, position.y, ahead.x, ahead.y);
    }
    if (diff > 0) {
      //print(d_mag + " ");
      //println("vai batter"); 
      // // velocity.mult(0);
      distance.normalize();


      distance.mult(diff);
      distance.limit(maxforce);

      velocity = PVector.sub(velocity, distance);
      //  velocity.normalize();
      velocity.limit(maxspeed);

      PVector force = steer(ahead, target, velocity);
      force.mult(-1);
      return force;
    } else {

      distance = PVector.sub(target, position);
      d_mag = distance.mag();
      diff = threshold - d_mag;
      if (diff > 0) {
        PVector force = steer(ahead, target, velocity);
        force.mult(-1);
        return force;
      } else {
        return new PVector(0, 0);
      }
    }
  }



  /*
*   TESTES 
   */

  void test_arrive() {
    PVector arrive_force = arrive(new PVector(mouseX, mouseY), false);
    PVector wander_force = wander();

    if (arrive_force.mag() > 0) {
      wander_force.mult(0);
    }

    apply_force(wander_force);
    apply_force(arrive_force);


    float r =  0.5*((maxspeed*maxspeed)/maxforce);
    noFill();
    stroke(255, 0, 0);
    ellipseMode(CENTER);
    ellipse(mouseX, mouseY, r, r);
  }


  PVector separate(ArrayList<Particle> v) {

    PVector sum = new PVector();
    PVector steer = new PVector(0, 0);
    int count = 0;

    for (Particle other : v) {
      float d = PVector.dist(position, other.position);

      if (d > 0 && d < safe_radius) {
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }

    if (count > 0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);

      steer =  PVector.sub(sum, velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  /*
* COMPLEX SYSTEMS
   */

  PVector align(ArrayList<Particle> v) {

    PVector sum = new PVector();
    PVector steer = new PVector(0, 0);
    int count = 0;

    for (Particle other : v) {
      float d = PVector.dist(position, other.position);

      if (d > 0 && d < scan_radius) {
        sum.add(other.velocity);
        count++;
      }
    }

    if (count > 0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);

      steer =  PVector.sub(sum, velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  PVector cohesion(ArrayList<Particle> v) {

    PVector sum = new PVector();
    PVector steer = new PVector(0, 0);
    int count = 0;

    for (Particle other : v) {
      float d = PVector.dist(position, other.position);

      if (d > 0 && d < scan_radius) {

        PVector diff = PVector.sub(other.position, position);
        sum.add(diff);
        count++;
      }
    }

    if (count > 0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);

      steer =  PVector.sub(sum, velocity);
      steer.limit(maxforce);
    }
    return steer;
  }





  //void test_01(){
  //  PVector seek_force = seek(new PVector(mouseX,mouseY), true);
  //  PVector wander_force = wander();

  //   if (seek_force.mag() > 0){
  //     wander_force.mult(0);
  //   }

  //   apply_force(wander_force);
  //   apply_force(seek_force);
  //}

  //void test_01(){
  //  PVector flee_force = flee(new PVector(mouseX,mouseY), true);
  //  PVector wander_force = wander();

  //   if (flee_force.mag() > 0){
  //     wander_force.mult(0);
  //   }

  //   apply_force(wander_force);
  //   apply_force(flee_force);
  //}
}