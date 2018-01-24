String target = "to be or not to be";
float mutationRate = 0.01;
int totalPopulation = 50;  
int totalGeneration = 0;

  
DNA bestFitness;
float avgFitness;

boolean evaluate = false;

DNA[] population = new DNA[totalPopulation];
ArrayList<DNA> matingPool;

class DNA {
  
  char[] genes = new char[18];
  float fitness;

  
  DNA(){
    for (int i = 0; i < genes.length; i++){
      genes[i] = (char) random(32,128);
    }
 }
 
 void fitness(){
  
   int score = 0;
   for (int i = 0; i < genes.length; i++){
     if (genes[i] == target.charAt(i)){
       score++;
   }   
   fitness = float(score) / target.length();   
  } 
 }
 
 DNA crossover(DNA partner){
   
   DNA child = new DNA();
   
   int midpoint = int (random (genes.length));
   for (int i = 0; i < genes.length; i++){
    if (i > midpoint){
      child.genes[i] = genes[i];
   }else {
    child.genes[i] = partner.genes[i]; 
   }
        
  
  }
   return child;
 }
 
 void mutate(){
  
   for (int i = 0; i < genes.length; i++){
    if (random(1) < mutationRate){
     genes[i] = (char) random(32,128); 
    }
   }
   
 } 
 
 String getPhrase(){
  return new String(genes); 
 }
 
}



void setup(){
  
  size(640,480);
  
  for (int i =0; i < population.length; i++){
   population[i] = new DNA();  //<>//
  }
  
}


void draw(){
  background(255);
  
  if (!evaluate){
  
  totalGeneration++;
  
  //calculate fitness
  for (int i =0; i < population.length; i++){
   population[i].fitness();
  }
  
    //best phrase
  
  bestFitness = population[0];
  avgFitness = 0.0;
  
  for (int i = 1; i < population.length - 1; i++){
    avgFitness += population[i].fitness;
    if (bestFitness.fitness < population[i].fitness){
      bestFitness = population[i];
    }  
  }
  
  if (target.equals(bestFitness.getPhrase())){
    evaluate = true;
  }
 
  avgFitness /= population.length;
 
 // creating a matingPool 
  matingPool = new ArrayList<DNA>();
  
  for (int i = 0; i < population.length; i++){
    int n = int (population[i].fitness * 100);
    for (int j = 0; j < n; j++){
      matingPool.add(population[i]);  
    }  
  }
  
  //reprodution
  
  for (int i = 0; i < population.length; i++){
    int a = int(random(matingPool.size()));
    int b = int(random(matingPool.size()));

    DNA parentA = matingPool.get(a);
    DNA parentB = matingPool.get(b);
    DNA child = parentA.crossover(parentB);
    child.mutate();
  
    population[i] = child;
  }
  
  }
  //show results
  
 
 
  fill(0);
  textSize(16);
  text("Best Phrase:",10,30);

  textSize(32);
  text(bestFitness.getPhrase(),10,80);

  textSize(16);
  text("Total Population: ",10,150);
  text(totalPopulation,150,150);
  text("Total Generation: ",10,180);
  text(totalGeneration,150,180);
  text("Avg Fitness:      ",10,210);
  text(avgFitness,150,210);
  text("Mutation Rate:    ",10,240);
  text(mutationRate*100 + " %",150,240);

}