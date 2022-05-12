ArrayList<Wall> murallas = new ArrayList<Wall>();
ArrayList<agent> hiders = new ArrayList<agent>();
ArrayList<agent> saved = new ArrayList<agent>();
ArrayList<PVector> Points = new ArrayList<PVector>();

Race M_path = new Race();
time timer = new time();
int gen = 0;
float better = 0;
int cant_eyes = 8;
int outputs_moves = 3;
int TOTAL = 20;
void setup(){
    //fullScreen();
    size(700,700);
    fill(255,0,0);
    rect(20,100,100,20);
    murallas.clear();
    M_path.race.clear();
    murallas.add(new Wall(0,0,width-1,0));
    murallas.add(new Wall(0,0,0,height-1));
    murallas.add(new Wall(width-1,0,width-1,height-1));
    murallas.add(new Wall(0,height-1,width-1,height-1));
    /*murallas.add(new Wall(210,170,400,400));
    murallas.add(new Wall(510,170,600,400));
    murallas.add(new Wall(10,340,400,460));
    murallas.add(new Wall(10,80,100,70));
    murallas.add(new Wall(60,220,200,240));*/
    make_out();
    for(int a=0;a<TOTAL;a++){
      hiders.add(new agent(80,400,cant_eyes,M_path));
    }

}


void draw(){
  
  background(255);
  text(gen,100,10);
  int cont = 0;
  text(better,50,10); 
  for(int a =0 ;a<hiders.size();a++){
    fill(0);
    hiders.get(a).path.Check(hiders.get(a).pos);
    hiders.get(a).Cscore();
    better = max(better, 1-hiders.get(a).Fitness());
    
    if(!hiders.get(a).death){
      hiders.get(a).ClearCast();
      for(Wall p : murallas){
        for(int b = 0; b<hiders.get(a).cantRay; b++){
          hiders.get(a).cast(p,b);
        }
      }
      hiders.get(a).show();
      hiders.get(a).calDist();
           //ve.printDist();
      hiders.get(a).move();
      //hiders.get(a).pos = new PVector(mouseX,mouseY);
      hiders.get(a).update();
    }else{
      saved.add(hiders.get(a));
      hiders.remove(a);
    }
  }
  if(timer.timer(800)){
    for(int a =0;a<hiders.size();a++){
      saved.add(hiders.get(a));
      
    }
    hiders.clear();
  }
  text(timer.iterate,20,20);
  if(hiders.size() == 0){
    timer.iterate = 1;
    NextGeneration();
    
  }
      rect(30,400,90,20);
  for(Wall p : murallas){
 //   p.show();
  }
  M_path.show(); 
}


void keyPressed(){
  setup();
}
