

class Perceptron {
  float[] weights;
  float lr = 0.01;

  Perceptron(int n) {
     weights= new float[n];
    for (int i = 0; i < weights.length; i++) {
      weights[i] = random(-1, 1);
    }
  }  

  int feedforward(float[] inputs) {
    float sum = 0;
    for (int i = 0; i < weights.length; i++) {
      sum += inputs[i] * weights[i];
    }   
    int output = activate(sum);
    return output;
  }
  
  int train(float[] inputs, int target){
    
   int guess = feedforward(inputs);
   int error = target - guess;
   
   for (int i = 0; i < weights.length; i++){
    weights[i] += error * inputs[i] * lr; 
   }
   return error;
  }
  
  float guessY(float x){
    float w0 = weights[0];
    float w1 = weights[1];
    float w2 = weights[2];
    
    return -(w2/w1) - (w0/w1)*x;
    
  }
  
  //Activation Function
int activate(float s) {   
  if (s > 0) {
    return 1;
  } else {      
    return -1;
  }
}
  
}