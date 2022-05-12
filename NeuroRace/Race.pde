class Race{
    ArrayList<PVector> race = new ArrayList<PVector>();
    int puntaje = 0;
    float total_d = 0;
    Race(){
    
    }
    void Check(PVector pos){
      if(race.size()!= 0 && puntaje < race.size())
      if(PVector.dist(pos,race.get(puntaje)) < 65){
        puntaje++;
      }
    }
    float distance(){
      total_d = 0;
      for(int a = puntaje; a < race.size()-1;a++){
         total_d += PVector.dist(race.get(a),race.get(a+1));
      }
      return total_d;
    }
    float Score(PVector pos){
      total_d = 0;
      float out_d = 0;
      
      for(int a = 0; a < race.size()-1;a++){
         total_d += PVector.dist(race.get(a),race.get(a+1));
      }
      if(race.size()!=0)out_d += PVector.dist(race.get(0),pos);
      if(puntaje < race.size()-2){
      for(int a = 0; a < puntaje;a++){
         out_d += PVector.dist(race.get(a),race.get(a+1));
      }
      }
      if(puntaje >= race.size()-2)return 0;
      return (total_d - out_d)/total_d;
    }
    
    void show(){
      for(PVector pos : race){
        fill(130);
          ellipse(pos.x,pos.y,4,4);
      }
    
    }
    
    Race copy(){
      Race sample = new Race();
      for(PVector pos : race ){
        sample.race.add(pos);
      }
      return sample;
    }
}
