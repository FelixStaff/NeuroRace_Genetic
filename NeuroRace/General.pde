int may(float guess[]){
  float answer = 0;
  int pos = 0;
  for(int a = 0;a<guess.length;a++){
    if(guess[a] > answer){
      answer = guess[a];
      pos = a;
    }
  }
  return pos;
}


PVector perpendicular1(PVector vector, float magnitud){
  PVector per = new PVector();
  
    per = PVector.mult(PVector.fromAngle(vector.heading() + PI/2),magnitud);
  
  return per;
}

PVector perpendicular2(PVector vector, float magnitud){
  PVector per = new PVector();
  
    per = PVector.mult(PVector.fromAngle(vector.heading() - PI/2),magnitud);
  
  return per;
}


PVector direct(PVector vector, float magnitud){
  PVector dir = new PVector();
  
    dir = PVector.mult(PVector.fromAngle(vector.heading()),magnitud);
  return dir;
}

PVector oposite(PVector vector, float magnitud){
  PVector dir = new PVector();
  
    dir = PVector.mult(PVector.fromAngle(vector.heading()+PI),magnitud);
  return dir;
}
