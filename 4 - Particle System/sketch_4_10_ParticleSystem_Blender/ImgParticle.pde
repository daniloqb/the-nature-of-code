class ImgParticle extends Particle{

  PImage img;
  
  ImgParticle(PVector l, PImage img_){
      super(l);  
      img = img_;
  }
  
  void display(){
    imageMode(CENTER);
    tint(lifespan);
    image(img,location.x,location.y);
  }


}