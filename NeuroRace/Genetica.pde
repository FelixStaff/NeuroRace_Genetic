void NextGeneration(){
    gen++;
    calculateFitness();
    for(int a =0 ; a < TOTAL ;a ++){
      hiders.add(pickOne());
    }
    saved.clear();
}

agent pickOne(){
    int index = 0; 
    float r  = random(1);
    while(r > 0){ //<>//
      r -= saved.get(index).fitness; //<>//
      index++; //<>//
    } //<>//
    index--; //<>//
    agent a = saved.get(index);
    agent child = new agent(80,400,cant_eyes,M_path,a.brain);
    child.mutate();
    return child;
}


void calculateFitness(){
  float sum = 0;
  for(agent ve : saved){ //<>//
    sum += ve.Score; //<>//
  } //<>//
  
  for(agent ve : saved){ //<>//
    ve.fitness = ve.Score/sum; //<>//
  } //<>//
}
