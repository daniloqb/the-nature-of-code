class Trainer {

  Point[] trp;
  Perceptron per;
  int training_step = 0;
  float error = 0;

  Trainer(Point[] points_, Perceptron per_) {
    trp = points_;
    per = per_;
  }


  void step_train() {
    Point pt = trp[training_step];
    float[] inputs = {pt.x, pt.y, pt.bias};
    int target = pt.label;
    error += per.train(inputs, target);
    training_step = (training_step +1) % trp.length;
    if (training_step == 0) {
      error /= trp.length;
    }
  }

  void train() {
    training_step = 0;
    error = 0;
    for (Point pt : trp) {
      float[] inputs = {pt.x, pt.y, pt.bias};
      int target = pt.label;
      error += per.train(inputs, target);      
    }
    error /= trp.length;
  }

  float getError() {
      return error;
  }
}