Perceptron brain;
Point[] points = new Point[100];


Trainer tr;

int trainingIndex = 0;

void setup() {
  size(800, 800);
  brain = new Perceptron(3);


  for (int i = 0; i < points.length; i++) {
    points[i] = new Point();
  }
  for (int i = 0; i < brain.weights.length; i++) {
  } 
  tr = new Trainer(points,brain);
}


void draw() {
  background(255);
  frameRate(30);
  strokeWeight(2);
  stroke(0);
  Point p1  = new Point(-1,f(-1));
  Point p2  = new Point(1,f(1)); 

  line(p1.pixelX(),p1.pixelY(), p2.pixelX(), p2.pixelY());

  Point p3  = new Point(-1,brain.guessY(-1));
  Point p4  = new Point(1,brain.guessY(1)); 

  line(p3.pixelX(),p3.pixelY(), p4.pixelX(), p4.pixelY());

  
  for (Point pt : points) {
    pt.show();
  }

  for (Point pt : points) {
    float[] inputs = {pt.x, pt.y, pt.bias};
    int target = pt.label;


    int guess = brain.feedforward(inputs);
    if (guess == target) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    noStroke();
    ellipse(pt.pixelX(), pt.pixelY(), 8, 8);
  }
  
  tr.step_train();
  println("Error " + tr.getError());
}
void mouseClicked(){
  //tr.train();
  //println("Error " + tr.getError()); 
  
  points = new Point[100];
  for (int i = 0; i < points.length; i++) {
    points[i] = new Point();
  }

  tr = new Trainer(points,brain);
}