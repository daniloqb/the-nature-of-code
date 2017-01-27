Pendulum p;


void setup(){

  size(640,360);
  
  p =  new Pendulum(new PVector(width/2,10),200);
}


void draw(){

  background(255);

  p.go();
  
}



void mousePressed() {
  p.clicked(mouseX,mouseY);
}

void mouseReleased() {
  p.stopDragging();
}