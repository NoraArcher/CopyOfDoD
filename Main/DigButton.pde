//public class DigButton extends Button{
  
//  //int super.x, super.y;
//  //boolean super.active, super.selected;

//  DigButton(int a, int b){
//    super.x = a;
//    super.y = b;
//    super.active = false;
//  }
  
//  void display(){
//    int opacity = 200;
//    stroke(169);
//    if (super.active){
//      opacity = 250;
//      stroke(0);
//    }
//    strokeWeight(5);
//    fill(178, 186, 187, opacity);//DarkGray
//    rect(x-60, y-40, 120, 80);
//    fill(211, 84, 0, opacity);//OrangeyBrown
//    textSize(60);
//    text("DIG", x-52, y+20);
//  }
  
//  void clicked(){//implemented differently than in abstract outline
//  }
  
//  int clicked(ArrayList<Scene> sets, Player m){
//    //print("dig away?");
//    Scene c;
//    int answer = -1;
//    active = false;
//    for (int i = 1; i < sets.size(); i++){//change to size()-2 when Defeat+Victry are added
//      c = sets.get(i);
//      if (!c.isFinished() && dist(c.getMapX(),c.getMapY(),m.getX(),m.getY()) < (m.getRadius()*7/5.0)){
//        answer = i;
//        active = true;
//      }
//    }
//    return answer;
//  }
  
//}
