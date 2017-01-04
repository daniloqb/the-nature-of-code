
class Vect2D{
 
  float x;
  float y;
  
  Vect2D(float x_, float y_){
    
    x = x_;
    y = y_;
  }
  
  void add(Vect2D v){
   
    x += v.x;
    y += v.y;
  }
  
  void sub(Vect2D v){
    x -= v.x;
    y -= v.y;
  } 
  
  void mul(float n){
   
    x *= n;
    y *= n;
    
      println(x);
  }


  void div(float n){
   
    x /= n;
    y /= n;
    
      println(x);
  }
}


  Vect2D center;
  Vect2D v;
  
  float n = 2;

void setup(){

  center = new Vect2D(width/2, height/2);

  v = new Vect2D(10, 10);

  size(600,360);
  background(255);
}





void draw(){
  
  background(255);
  
   translate(center.x,center.y);
 
  line(0,0,v.x,v.y);
  
 
  
}


void mouseClicked(){
  

  v.div(2);
  

  
}