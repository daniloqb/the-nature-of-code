
class DNA {
  
  PVector[] genes;
  float maxforce = 0.1;

  
  DNA(){
    genes = new PVector[lifetime];
    for (int i =0; i < genes.length; i++){
      genes[i] = PVector.random2D();
      genes[i].mult(random(0,maxforce));
    }
  }
 
 
 DNA crossover(DNA partner){
   DNA child = new DNA();
   
   int midpoint = int(random(genes.length -1));
   for (int i = 0; i < genes.length; i++){
     if (i > midpoint){
       child.genes[i] = genes[i];
     } else{
       child.genes[i] = partner.genes[i];
     }
  }
  return child;
 }
 
 void mutate(float mutationRate){
  
   for (int i = 0; i < genes.length; i++){
    if (random(1) < mutationRate){
      genes[i] = PVector.random2D();
      genes[i].mult(random(0,maxforce));
   }
   
 } 
 
}
}