class Population{
  
  float mutationRate;
  
  Rocket[] population;
  ArrayList<Rocket> matingPool;
  int generations;
  float maxFitness;
  float avgFitness;
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
    avgFitness = 0;
    for (int i = 0; i < population.length; i++){
     population[i].fitness(target);    
     avgFitness += population[i].fitness;
     if (population[i].fitness > maxFitness){
       maxFitness = population[i].fitness;
     }
    }
    avgFitness /= population.length;
  }
  
  void selection(){
    
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
    generations++;
  }
  
    

  
   Rocket getRocket(){
     int besafe = 0;
     int index = 0;
     while(besafe < population.length){
       besafe++;
      index = int (random (population.length - 1));
      float r = random(maxFitness);
      if ( (population[index].fitness - r) >= 0){
        return population[index];
      }
     }
    index = int (random (population.length - 1));
    return population[index];
  }
  
  void live(){
    for (int i = 0; i < population.length; i++){
      population[i].run();  
    }
  }
  
    //void fitness(PVector target){
  //  maxFitness = 0;
  //  for (int i = 0; i < population.length; i++){
  //   population[i].fitness(target);
  //   population[i].geneCounter = 0;
  //   if (population[i].fitness > maxFitness){
  //     maxFitness = population[i].fitness;
  //   }
  //  }
  //  for (int i = 0; i < population.length; i++){
  //    population[i].fitness /= maxFitness;
  //  }
  //}
  
    //void selection(){
  
    //matingPool = new ArrayList<Rocket>();
    //for (int i =0; i < population.length; i++){
    // int n = int (population[i].fitness * 100);
    // for (int j = 0; j < n; j++){
    //  matingPool.add(population[i]); 
    // }
    //}
  
  //}
//  
  //Rocket getRocket(){
  //  int b = int (random (matingPool.size()));
  //  Rocket parent = matingPool.get(b);
  //  return parent;
  //}
  
  
  float getMaxFitness(){
    return maxFitness;
  }
  
  float getAvgFitness(){
   return avgFitness;
  }
  
 int getGenerations(){
  return generations; 
 }
 
 int getPopulationSize(){
  return population.length; 
 }
 
 float getMutationRate(){
   return mutationRate;
 }
  
}