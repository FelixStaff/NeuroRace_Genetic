class time{

    int iterate = 0;
    boolean timer(int timet){
      iterate++;
      if(iterate%timet == 0)iterate = 0;
      if(iterate%timet == 0) return true;
      else return false;
      
    }

}
