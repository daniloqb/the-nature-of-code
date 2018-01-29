int lifetime;
int lifeCounter;
float mutationRate;
int populationSize;

Rocket rocket;
Target target;
ArrayList<Obstacle> obstacles;
Population population;


int x_margin = 150;
int y_margin = 80;

// scores

float avg_fit;
float max_fit;
int gen;


void setup(){
 
  size(640,480);
  lifetime = 500;
  lifeCounter = 0;
  populationSize = 50;
  mutationRate = 0.01;
  
  target = new Target(new PVector(width-30,height - 150));

  population = new Population(mutationRate, populationSize);
  
  obstacles = new ArrayList<Obstacle>();
  for (int i = 0; i < 3; i++){
    obstacles.add(new Obstacle(new PVector(random((width/2) - 50, (width/2) + 50),random((height/2) - 50), (height/2) + 50)));
  }
  
  gen = population.getGenerations();
  max_fit = population.getMaxFitness(); 
  avg_fit = population.getAvgFitness();
}


void draw(){
 
  
  background(255);

  if (lifeCounter < lifetime){
   population.live(); 
   lifeCounter++;
  } else{
   lifeCounter = 0;
   population.fitness(target.location);
   population.selection();
   population.reproduction();
   gen = population.getGenerations();
   max_fit = population.getMaxFitness();
   avg_fit = population.getAvgFitness();
  }
  
  for (Rocket rocket: population.population){
   for (Obstacle obs: obstacles){
     if(obs.checkCollision(rocket)){
       rocket.crashed = true;
       rocket.c1 = color(255,0,0);
     }
   }
  }
  
  target.run();
  target.checkCollision(population.population);
  
   for (Obstacle obs: obstacles){
    obs.run(); 
   }
  
  // show score
     
  fill(0);
  textSize(12);
  text("Population Size: " + populationSize, width - x_margin,height - y_margin);
  text("Generation: " + gen, width - x_margin,height - y_margin + 16);
  text("Max Fitness: " + max_fit, width - x_margin,height - y_margin + 32);
  text("Avg Fitness: " + avg_fit, width - x_margin,height - y_margin + 48);
  text("Mutation Rate: " + mutationRate, width - x_margin,height - y_margin + 64);
  text("LifeCounter: " + (lifetime - lifeCounter), width - x_margin,height - y_margin + 80);

    
}



 void mouseClicked() {
  target.location.x = mouseX;
  target.location.y = mouseY;
}