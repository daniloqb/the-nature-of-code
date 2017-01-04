
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


  float mag(){
   
    return sqrt(x*x +y*y);
  }
  
  
  Vect2D normalize(){
    
    float m = mag();
    Vect2D v = new Vect2D(x,y);
    
    if(m != 0){
      v.div(m);
    }
    
    return v;

}

}



  Vect2D center;
  Vect2D mouse;
  
  Vect2D v;



void setup(){

  center = new Vect2D(width/2, height/2);

  size(600,360);
  background(255);
}





void draw(){
  
  background(255);
  
   mouse = new Vect2D(mouseX,mouseY);
  
   mouse.sub(center);
  
   v = mouse.normalize();
  
  translate(center.x,center.y);
  
  line(0,0,v.x*10,v.y*10);
  
  println(mouse.mag());
 
  
}