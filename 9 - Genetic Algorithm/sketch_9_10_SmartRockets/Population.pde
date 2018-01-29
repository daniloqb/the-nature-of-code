class Population{
  
  float mutationRate;
  
  Rocket[] population;
  ArrayList<Rocket> matingPool;
  int generations;
  float maxFitness;
  int populationSize;
  
  Population(float m, int s){
    mutationRate = m;
    populationSize = s;
    population = new Rocket[populationSize];
    
    for (int i = 0; i < population.length; i++){
      population[i] = new Rocket();
    }
  }
  
  void fitness(PVector target){
    maxFitness = 0;
    for (int i = 0; i < population.length; i++){
     population[i].fitness(target);
     population[i].geneCounter = 0;
     if (population[i].fitness > maxFitness){
       maxFitness = population[i].fitness;
     }
    }
    for (int i = 0; i < population.length; i++){
      population[i].fitness /= maxFitness;
    }
  }
  void selection(){
  
    matingPool = new ArrayList<Rocket>();
    for (int i =0; i < population.length; i++){
     int n = int (population[i].fitness * 100);
     for (int j = 0; j < n; j++){
      matingPool.add(population[i]); 
     }
    }
  
  }
  void reproduction(){
  
    Rocket[] newPopulation = new Rocket[populationSize];
    for (int i = 0; i < population.length; i++){

      
      Rocket parentA = getRocket();
      Rocket parentB = getRocket();
      DNA child = parentA.dna.crossover(parentB.dna);
      child.mutate(mutationRate);
      newPopulation[i] = new Rocket(child);
    }
    population = newPopulation;
  }
  
  Rocket getRocket(){
    int b = int (random (matingPool.size()));
    Rocket parent = matingPool.get(b);
    return parent;
  }
  
  void live(){
    for (int i = 0; i < population.length; i++){
      population[i].run();  
    }
  }
  
}