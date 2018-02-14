
float f(float x){
  return 0.3 *x +0.2;
}


class Point{ 
  
  float x;
  float y;
  float bias = 1;
  int label;
  
  Point(){
   x = random(-1,1);
   y = random(-1,1);
   
   float yLine = f(x);
   
   if( y > yLine){
     label = 1;
   } else{
     label  =-1;
   }
  }
  
  Point(float x_, float y_){
   x = x_;
   y = y_;
   
   float yLine = f(x);
   
   if( y > yLine){
     label = 1;
   } else{
     label  =1;
   }
  }
  
  void show(){
    strokeWeight(2);
   stroke(0);
   if (label == 1){
     fill(255);
   } else {
     fill(0);
   }
    float px = pixelX();
    float py = pixelY();
   ellipse(px,py,12,12);
  }
  
  float pixelX(){
       return map(x, -1,1,0,width);
  }
  
  float pixelY(){
       return map(y, -1,1,height,0);

  }
}