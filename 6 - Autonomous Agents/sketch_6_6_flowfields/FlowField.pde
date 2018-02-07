class FlowField{
  
  PVector[][] field;
  int cols,rows;
  int resolution;
  float pace = 0;
  float vel_noise=0.01;
  
  
  FlowField(){
   
    resolution = 10;
    cols = width / resolution;
    rows = height / resolution;
    field = new PVector[cols][rows];
  }
  
  void generate(){ 
  //  generate_random();
  generate_perlin_noise();
  // generate_side();
 // generate_center();
  
  }
  
  void generate_side(){
    for(int i = 0; i < cols; i++){
     for (int j = 0; j < rows; j++){
      field[i][j] = new PVector(1,0); 
     }
    }
  }
  
  void generate_random(){
    for(int i = 0; i < cols; i++){
     for (int j = 0; j < rows; j++){
      field[i][j] = PVector.random2D(); 
     }
    }    
  }
  
 void generate_perlin_noise(){
  float xoff = pace;
  for(int i = 0; i < cols; i++){
    float yoff = pace;
     for (int j = 0; j < rows; j++){
       float theta = map(noise(xoff,yoff),0,1,0,TWO_PI);
      field[i][j] = new PVector(cos(theta),sin(theta)); 
      yoff += 0.1;
     }
    xoff += 0.1;  
  }
  pace += vel_noise;

 }
 
   void generate_center(){
     
     PVector to = new PVector(width/2, height/2);
     for(int i = 0; i < cols; i++){
       for (int j = 0; j < rows; j++){
         PVector from = new PVector(i*resolution,j*resolution);
         
         field[i][j] = PVector.sub(to,from);
         field[i][j].setMag(resolution*0.09);

         
     }
    }    
  }
 
 void display_field(){
   int r = resolution / 2;
   noFill();
   
  
   for (int i = 0; i < cols; i++){
     for (int j = 0; j < rows; j++){
       float x = r* field[i][j].x;
       float y = r *field[0][0].y;
       
       int pos_x = i*resolution;
       int pos_y = j*resolution;
       float d = dist(pos_x,pos_y,pos_x+x,pos_y+y);

       color to = color(255,255,255);
       color from = color(255,90,255);
       
       color col = lerpColor(from, to, d/(r*sqrt(2)));
       stroke(col);
       line(pos_x,pos_y,pos_x+x,pos_y+y);
     }
     
   }
 }
 
 void display_grid(){
   
   for (int i = 0; i < cols; i++){
     int xoff = i * resolution;
     for (int j = 0; j < rows; j++){
       int yoff = j * resolution;
      
       noFill();
       stroke(255);
       rect(xoff,yoff,xoff+resolution, yoff+resolution);      
    }
   }
 }
 
 PVector lookup(PVector l){
  int column = int(constrain(l.x/resolution,0,cols-1)); 
  int row = int(constrain(l.y/resolution,0,rows-1)); 
  return field[column][row].copy();
 }
  
}