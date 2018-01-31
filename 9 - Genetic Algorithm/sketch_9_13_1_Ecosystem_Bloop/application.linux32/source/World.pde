class World{
 
  ArrayList<Bloop> bloops;
  ArrayList<Food> foods;
  float max_size, min_size, avg_size;
  float reproduction_rate = 0.0001;
  float mutation_rate = 0.01;
  
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
  
  void update(){
   
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
  
  void eat(){
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
  
  void evolve(){

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
  float p = (float(foods.size()) / bloops.size()) *100;

  reproduction_rate = (0.00005 * pow(2,log(p))) + (1/bloops.size())/100  ;
  float a = pow(2,bloops.size());
  
  float f = ((float(1)/a))*100;
  mutation_rate = 0.01 + f;
  }
  
  int getNumberOfFoods(){
    return foods.size();
  }
  int getNumberOfBloops(){
    return bloops.size();
  }
  float getMaxSize(){
    return max_size;
  }
  float getMinSize(){
    return min_size;
  }
  float getAvgSize(){
    return avg_size;
  }
  float getReprodutionRate(){
    return reproduction_rate;
  }
  
  float getMutationRate(){
    return mutation_rate;
  }

  
}