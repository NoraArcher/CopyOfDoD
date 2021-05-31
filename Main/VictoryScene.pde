public class VictoryScene extends Scene {
  
  //getMapX(), getMapY(), isFinished(), toString()
  //int super.endCount;

  VictoryScene() {
    super((width/2)-300, 200, "V I C T O R Y");
  }
  
  void display(){//to be called in draw
  }
  
  void display(Player p){
    background(206, 172, 65);
    p.setRadius(200);  p.setXY((width/2), (height/2)+60);
    p.display();
    textSize(100);  fill(0, 128, 128);//teal
    //fill(75, 0, 130);//indigo
    text(toString(), getMapX(), getMapY());
    fill(245, 245, 245);
    //trophy shape?
  }
  
  void keyHandler(int code){
  }
  
  void mouseHandler(){
  }

  void mousePressedHandler(){
  }

  void mouseReleasedHandler(){
  }
  
}
