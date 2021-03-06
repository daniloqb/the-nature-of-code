class Path{
  
 ArrayList<PVector> points;
 float radius;
 
 Path(){
  
   radius = 20;
   points = new ArrayList<PVector>();
   
 }
 
 void addPoint(float x, float  y){
   PVector point = new PVector(x,y);
   points.add(point);
 }
 
 
   PVector getStart() {
     return points.get(0);
  }

  PVector getEnd() {
     return points.get(points.size()-1);
}
 
 void display(){
  noFill();
   strokeWeight(radius * 2);
   stroke(0,100);
   beginShape();
   for (PVector p :points){
    vertex(p.x,p.y); 
   }
   endShape();
   strokeWeight(1);
   stroke(0);   
   beginShape();
   for (PVector p :points){
    vertex(p.x,p.y); 
   }
   endShape();
   
   
 }
 
}