public class DefeatScene extends Scene {
  
  //getMapX(), getMapY(), isFinished(), toString()
  //int super.endCount;
  int sandHeight;
  float peakWidth;

  DefeatScene() {
    super((width/2)-90, 145, "You Lost");
    sandHeight = height-100;
    peakWidth = 300;
  }
  
  void display(){//to be called in draw
  }
  
  void display(Player p){
    //color(239, 222, 194);//pale sand
    //color(215, 175, 114);//light brown, usable for detailing?
    //color(218, 194, 124);//light sand
    background(218, 194, 124);
    p.setRadius(150);  p.setXY((width/2), (height/2)+100);
    p.display();
    textSize(40);  fill(255, 0, 0);
    text(toString(), getMapX(), getMapY());
    fill(206, 172, 65);
    quad((width/2)-300, height-100, (width/2)+300, height-100,
         (width/2)+peakWidth, sandHeight, (width/2)-peakWidth, sandHeight);
    if (peakWidth > 5 && sandHeight > 200){
      peakWidth-=0.5;
      sandHeight-=1;
    }
  }
  
  void keyHandler(int code){
    if (code == 72){//H for help
      //arm sticks out for help?
    }
  }
  
  void mouseHandler(){
  }

  void mousePressedHandler(){
  }

  void mouseReleasedHandler(){
  }
  
}
