public class DigButton {
  
  int x, y;
  boolean active;//active here means able to be clicked

  DigButton(int a, int b){
    x = a;
    y = b;
    active = false;
  }
  
  void display(){
    int opacity = 200;
    stroke(169);
    if (active){//how to passively turn active on is yet undone
      opacity = 250;
      stroke(0);
    }
    strokeWeight(5);
    fill(178, 186, 187, opacity);//DarkGray
    rect(x-60, y-40, 120, 80);
    fill(211, 84, 0, opacity);//OrangeyBrown
    textSize(60);
    text("DIG", x-52, y+20);
  }
  
  int clicked(ArrayList<Scene> sets, Player m){
    //print("dig away?");
    Scene c;
    int answer = -1;
    for (int i = 1; i < sets.size(); i++){
      c = sets.get(i);
      if (dist(c.getMapX(),c.getMapY(),m.getX(),m.getY()) < 50){
        answer = i;
      }
    }
    return answer;
  }
  
  float getX(){
    return x;
  }
  
  float getY(){
    return y;
  }
  
  boolean isActive(){
    return active;
  }
  
  void setActive(boolean a){
    active = a;
  }
  
}
