import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_9_13_1_Ecosystem_Bloop extends PApplet {

int x_margin = 216;
int y_margin = 136;
float t;
int d,h,m,s;

World world;

public void setup(){
  
 world = new World(10,10);
 frameRate(30);

}



public void draw(){
  background(255);
  world.update();

  
  
  
  float n_b = world.getNumberOfBloops();
  float n_f = world.getNumberOfFoods();
  
  float avg_fb = (n_f / n_b) *100;
  
  if (n_b > 0){
    t = frameCount / frameRate;
    s = PApplet.parseInt(t % 60);
    m = PApplet.parseInt((t / 60) % 60);
    h = PApplet.parseInt(t / 3600);
    d = h / 24;
    h %= 24;
}
  
  fill(0);
  textSize(12);
  text("Bloops Population: " + n_b , width - x_margin,height - y_margin);
  text("Foods Population: " + n_f , width - x_margin,height - y_margin + 16);
  text("Foods per Bloop: " + avg_fb + "%", width - x_margin,height - y_margin + 32);
 
  text("Max Size: " + world.getMaxSize(), width - x_margin,height - y_margin + 48);
  text("Min Size: " + world.getMinSize(), width - x_margin,height - y_margin + 64);
  text("Avg Size: " + world.getAvgSize(), width - x_margin,height - y_margin + 80);
  text("Reprodution Rate: " + world.getReprodutionRate(), width - x_margin,height - y_margin + 96);
  text("Mutation Rate: " + world.getMutationRate(), width - x_margin,height - y_margin + 112);
  text("Time Passed: " + d +"d "+ h +"h " + m + "m " + s +"s " , width - x_margin,height - y_margin + 128);



}
class Bloop{
 
  PVector location;
  float r;
  float maxspeed;
  float xoff,yoff;
  float health = 500;
  boolean dead = false;
  
  DNA dna;
  
  Bloop(){
    location = new PVector(random(width), random(height));
    dna = new DNA();
    init();
  }
  
 Bloop(PVector l_,DNA dna_){
    location = l_;
    dna = dna_;
    init();
 }
 
 public void init(){ 
    xoff = random(1000);
    yoff = random(1000);
    r = map(dna.genes[0],0,1,8,150);
    maxspeed = map(dna.genes[0],0,1,10,0.1f);
 }
  
  public void update(){
    
   if (!dead){
     float vx = map(noise(xoff),0,1,-maxspeed,maxspeed);
     float vy = map(noise(yoff),0,1,-maxspeed,maxspeed);
  
     PVector velocity = new PVector(vx,vy);
     location.add(velocity);
     xoff += 0.01f;
     yoff += 0.01f;
   
     checkEdges();
   
     health--;
     if(health <= 0.0f){
       dead = true;
     }
    }
  }
  
  public boolean isDead(){
    return dead;
  }
  
  public void display(){
    float alpha = map(health,0,500,0,255);
    
    fill(255,0,100,alpha);
    ellipse(location.x, location.y,r,r);
  }
  
  public void checkEdges(){
   
    if (location.x < 0){
      location.x = width;
    } else if (location.x > width){
      location.x = 0;
    }
    
    if (location.y < 0){
      location.y = height;
    } else if (location.y > height){
      location.y = 0;
    }
  
  } 
  
  public Bloop reproduce(float mutationRate){
   DNA childDNA = dna.copy();   
   childDNA.mutate(mutationRate);
   PVector l = location.copy();
   return new Bloop(l,childDNA);
   //return new Bloop();
  }
  
  
  
  
}
class DNA{
 float [] genes;
 
 DNA(){
  genes = new float[1];
  
  for (int i = 0; i < genes.length; i++){
   genes[i] = random(0,1); 
  }
 }
 
 DNA(float[] newgenes){
  genes = newgenes; 
 }
 
 public DNA copy(){
  float[] newgenes = new float[genes.length];
  for (int i = 0; i < newgenes.length; i++){
    newgenes[i] = genes[i]; 
  }
  
  return new DNA(newgenes);
  
 }
 
 public void mutate(float mutationRate){
  
   for (int i = 0; i < genes.length; i++){
    if (random(1) < mutationRate){
      genes[i] = random(0,1);
    }   
 }  
}
  
}
class Food{
  
 PVector location;
 float r = 8;
 
 Food(){
  location = new PVector(random(width), random(height)); 
 }
 
 Food(PVector l_){
   location = l_;
 }
 
 public void update(){
   
 }
 
 public void display(){
   fill(0);
   ellipse(location.x,location.y,r,r);   
 }
  
}
class World{
 
  ArrayList<Bloop> bloops;
  ArrayList<Food> foods;
  float max_size, min_size, avg_size;
  float reproduction_rate = 0.0001f;
  float mutation_rate = 0.01f;
  
  World(int n_bloops, int n_foods){
    bloops = new ArrayList<Bloop>();
   for (int i = 0; i < n_bloops; i++){
     
     bloops.add(new Bloop());
   }
   
   foods = new ArrayList<Food>();
   for (int i = 0; i < n_foods; i++){
     foods.add(new Food());
   }
  }
  
  public void update(){
   
    for (Bloop b: bloops){
     b.update();
     b.display();
    }
    
    for (Food f: foods){
     f.update();
     f.display();
    }
    
    eat();
    evolve();
  }
  
  public void eat(){
    for (Bloop b: bloops){
     for (int i = (foods.size() -1); i >=0; i--){
       Food f = foods.get(i);
       float d = PVector.dist(b.location,f.location);
       if (d < (b.r + f.r)/2){
         b.health += 500;
         foods.remove(i);
       }
     }
    }
  }
  
  public void evolve(){

    max_size = 0;
    min_size = 1000;
    avg_size = 0;
    
   for (int i = bloops.size() -1; i >= 0; i--){
     Bloop b = bloops.get(i);
    
     if ( b.r > max_size){ 
       max_size = b.r;
     }else if (b.r < min_size){
       min_size = b.r;
     }
     avg_size += b.r;
     
     
     if (b.isDead()){
       foods.add(new Food(b.location));
       bloops.remove(i);
     } else{
       if (random(1) < reproduction_rate){
        Bloop child = b.reproduce(mutation_rate);
        if (child != null){
          bloops.add(child); 
        }
        
     }
   }
  }
  avg_size /= bloops.size();
  float p = (PApplet.parseFloat(foods.size()) / bloops.size()) *100;

  reproduction_rate = (0.00005f * pow(2,log(p))) + (1/bloops.size())/100  ;
  float a = pow(2,bloops.size());
  
  float f = ((PApplet.parseFloat(1)/a))*100;
  mutation_rate = 0.01f + f;
  }
  
  public int getNumberOfFoods(){
    return foods.size();
  }
  public int getNumberOfBloops(){
    return bloops.size();
  }
  public float getMaxSize(){
    return max_size;
  }
  public float getMinSize(){
    return min_size;
  }
  public float getAvgSize(){
    return avg_size;
  }
  public float getReprodutionRate(){
    return reproduction_rate;
  }
  
  public float getMutationRate(){
    return mutation_rate;
  }

  
}
  public void settings() {  size(1500,850); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_9_13_1_Ecosystem_Bloop" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
