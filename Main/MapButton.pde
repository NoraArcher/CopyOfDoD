public class MapButton {
  
  int x, y;
  boolean active;

  MapButton(int a, int b){
    x = a;
    y = b;
    active = false;//active here means selected
  }
  
  void display(ArrayList<Scene> sets){
    int opacity = 250;
    
    if (active) {
      opacity = 200;
      //display tasks labels
      textSize(28);
      for (int i = 1; i < sets.size(); i++){//change to size()-2 when Defeat+Victry are added
        Scene c = sets.get(i);
        fill(0);
        if (c.isFinished()) fill(34, 139, 34);
        text(c.toString(), c.getMapX()-100, c.getMapY()+15);
      }
      //text("Swipe \nLicense", (width/4)+12, 160);
      //text("Follow Story", (width/2)-90, 440);
      //text("Clean Tablet", width-75-300, 380);
      stroke(169);
    } else {
      stroke(0);
    } 
    strokeWeight(5);
    fill(178, 186, 187, opacity);//DarkGray
    rect(x-75, y-40, 150, 80);
    fill(203, 67, 53, opacity);//Reddish
    textSize(60);
    text("MAP", x-63, y+20);
  }
  
  void clicked(){
    active = !active;
  }
  
  float getX(){
    return x;
  }
  
  float getY(){
    return y;
  }
  
  void setActive(boolean a){
    active = a;
  }
  
}
