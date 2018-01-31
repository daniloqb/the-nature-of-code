int x_margin = 216;
int y_margin = 136;
float t;
int d,h,m,s;

World world;

void setup(){
  size(1500,850);
 world = new World(10,10);
 frameRate(30);

}



void draw(){
  background(255);
  world.update();

  
  
  
  float n_b = world.getNumberOfBloops();
  float n_f = world.getNumberOfFoods();
  
  float avg_fb = (n_f / n_b) *100;
  
  if (n_b > 0){
    t = frameCount / frameRate;
    s = int(t % 60);
    m = int((t / 60) % 60);
    h = int(t / 3600);
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


 //<>//
}