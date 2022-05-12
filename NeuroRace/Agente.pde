

class agent{
    NeuralNetwork brain;
    Race path = new Race();
    float Score = 0;
    float fitness = 0;
    PVector pos;
    PVector vel;
    boolean seened = false;
    boolean death = false;
    int cantRay;
    PVector dir[];
    PVector points[];
    float dist[];
    float guess[];
    
      agent(float x, float y, int castRay_, Race r){
        brain = new NeuralNetwork(castRay_,18,outputs_moves);
        dist = new float[castRay_];
        pos = new PVector(x,y);
        dir = new PVector[castRay_];
        points = new PVector[castRay_];
        cantRay = castRay_;
        for(int a =0;a<cantRay;a++){
          dir[a] = PVector.mult(PVector.fromAngle((PI/cantRay)*a),10);
          points[a] = new PVector();
        }
        vel = new PVector(0,4);
        path = r.copy();
      }
      
      agent(float x, float y, int castRay_, Race r, NeuralNetwork brain_){
        brain = brain_.copy();
        dist = new float[castRay_];
        pos = new PVector(x,y);
        dir = new PVector[castRay_];
        points = new PVector[castRay_];
        cantRay = castRay_;
        for(int a =0;a<cantRay;a++){
          dir[a] = PVector.mult(PVector.fromAngle((PI/cantRay)*a),10);
          points[a] = new PVector();
        }
        vel = new PVector(0,4);
        path = r.copy();
      }

      void mutate(){
        brain.mutate(.2); //<>//
      }
      
      void show(){
        fill(0,255,0);
        
        if(seened == false){
          fill(0,0,255*Score);
        }
        if(death)fill(255,0,0);
        ellipse(pos.x,pos.y,10,10);
        for(int a=0;a<cantRay;a++){
          if(points[a] != null)
          line(pos.x,pos.y,points[a].x,points[a].y);
        }
      }
      void ClearCast(){
        for(int a=0;a<cantRay;a++){
          points[a] = null;
        }
      }
      void cast(Wall w, int a){
        float x1 = w.a.x;
        float y1 = w.a.y;
        float x2 = w.b.x;
        float y2 = w.b.y;
        
        float x3 = pos.x;
        float y3 = pos.y;
        float x4 = pos.x + dir[a].x;
        float y4 = pos.y + dir[a].y;
        
        float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
        if(den == 0){
        }
        float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4))/den;
        float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3))/den;
        PVector newPos = new PVector((x1 + t*(x2 - x1)) , (y1 + t*(y2 - y1)));
        //ellipse(newPos.x,newPos.y,5,5);
        if(t > 0 && t < 1 && u > 0){
          if(points[a] == null){
            points[a] = new PVector((x1 + t*(x2 - x1)) , (y1 + t*(y2 - y1)));
            return;
          }
          if(PVector.sub(pos,points[a]).mag() >= PVector.sub(pos,newPos).mag())
          points[a] = new PVector((x1 + t*(x2 - x1)) , (y1 + t*(y2 - y1)));
        }else{
        }
      }
      
      void calDist(){
        if(pos.x <= 0 || pos.y <= 0 || pos.x >= width || pos.y >= height)death = true;
        for(int a = 0;a < cantRay; a++){
          if(points[a] != null){
            dist[a] = PVector.sub(pos,points[a]).mag();
            if(dist[a] <= 5)death = true;
            
          }          
        }
        //dist[cantRay] = vel.x;
        //dist[cantRay+1] = vel.y;
      }
      
      void printDist(){
        for(int a=0;a<cantRay;a++){
          fill(0);
          if(points[a] != null)
          text(PVector.sub(pos,points[a]).mag(),20,((a+1)*20));
        }
      }
      void update(){
        vel.limit(5);
        pos.add(vel);
        for(int a =0;a<cantRay;a++){
          dir[a] = PVector.mult(PVector.fromAngle(vel.heading()+((PI/cantRay)*a)-(PI/2)),10);
          points[a] = new PVector();
        }
        //if(seened == false && Score>=0)Score-=.01;
      }
      
      void move(){
        guess = brain.feedForward(dist);
        switch(may(guess)){
          case 0:
            vel.add(perpendicular1(vel,0.4));
          break;
          case 1:
            vel.add(perpendicular2(vel,0.4));
          break;
          case 2:
            vel.add(0,0);
          break;
          case 3:
            vel.add(direct(vel,0.2));
          break;
          case 4:
            vel.add(oposite(vel,0.05));
          break;
        }
      }
      void Cscore(){
        Score = 1 - path.Score(pos);
      }
      float Fitness(){
        return path.Score(pos);
      }
}
