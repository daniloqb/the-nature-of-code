class Wave{

  int xspacing = 10;
  int w;
  
  PVector origin;
  float theta = 0.0;
  float amplitude;
  float period;
  float dx;
  float[] yvalues;


  Wave(PVector o, int w_, float a, float p){
    
    origin = o.get();
    w = w_;
    period = p;
    amplitude = a;
    
    dx = (TWO_PI/period) * xspacing;
    yvalues = new float[w/xspacing];
    
  }
  
  void calculate(){
  
    theta += 0.02;
    float x =theta;
    
    for(int i = 0; i < yvalues.length; i++){
    
      yvalues[i] = sin(x)*amplitude;
      x+=dx;
    
    }
  
  }
  
  
  void display(){
  
    for(int x=0; x < yvalues.length; x++){
      stroke(0);
      fill(0,50);
      ellipseMode(CENTER);
      ellipse(origin.x+x*xspacing,origin.y+yvalues[x],10,10);
    }
  
  }

}