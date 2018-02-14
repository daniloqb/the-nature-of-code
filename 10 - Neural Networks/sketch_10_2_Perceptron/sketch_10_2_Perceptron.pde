Perceptron brain;
Point[] points = new Point[100];
float error;

int trainingIndex = 0;

void setup() {
  size(800, 800);
  brain = new Perceptron();
  float[] inputs = {-1, 0.5};

  for (int i = 0; i < points.length; i++) {
    points[i] = new Point();
  }
}


void draw() {
  background(255);
  frameRate(30);
  
  line(0, 0, width, height);
  for (Point pt : points) {
    pt.show();
  }

  for (Point pt : points) {
    float[] inputs = {pt.x, pt.y};
    int target = pt.label;
   

    int guess = brain.guess(inputs);
    if (guess == target) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    noStroke();
    ellipse(pt.x, pt.y, 4, 4);
  }
  
  Point training = points[trainingIndex];
  float[] inputs = {training.x, training.y};
  int target = training.label;
  error += brain.train(inputs, target);
  trainingIndex++;
  if (trainingIndex == points.length){
    trainingIndex = 0;
    println( error/points.length);
    error = 0;
  }
}

//void mouseClicked(){
//  for (Point pt : points) {
//    float[] inputs = {pt.x, pt.y};
//    int target = pt.label;
//    brain.train(inputs, target);

//  }
//}