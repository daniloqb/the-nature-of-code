int lifetime;
int lifeCounter;
float mutationRate = 0.01;
int populationSize = 25;

Rocket rocket;
Target target;

Population population;

void setup(){
 
  size(640,480);
  lifetime = 500;
  lifeCounter = 0;
  
  target = new Target(new PVector(width/2,0));
 //<>//
  population = new Population(mutationRate, populationSize);
  
}


void draw(){
 
  
  background(255);
  
  if (lifeCounter < lifetime){
   population.live(); 
   lifeCounter++;
  } else{
   lifeCounter = 0; //<>//
   population.fitness(target.location);
   population.selection();
   population.reproduction();
    
  }
  
  target.run();
  
  
}