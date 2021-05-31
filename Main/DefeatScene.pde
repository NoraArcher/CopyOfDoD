public class DefeatScene extends Scene {
  
  //getMapX(), getMapY(), isFinished(), toString()
  //int super.endCount;
  float sandHeight, peakWidth;
  boolean help;

  DefeatScene() {
    super((width/2)-90, 155, "You Died");
    sandHeight = height-100;
    peakWidth = 300;
    help = false;
  }
  
  void display(){//to be called in draw
  }
  
  void display(Player p){
    //color(239, 222, 194);//pale sand
    //color(215, 175, 114);//light brown, usable for detailing?
    //color(218, 194, 124);//light sand
    background(218, 194, 124);
    p.setRadius(150);  p.setXY((width/2), (height/2)+60);
    p.display();
    fill(206, 172, 65);  noStroke();
    quad((width/2)-300, height-100, (width/2)+300, height-100,
         (width/2)+peakWidth, sandHeight, (width/2)-peakWidth, sandHeight);
    float pileSize = height-100-sandHeight;
    float levelWid = peakWidth+15;
    for (int i = 0; i < pileSize; i+=50){
      rect((width/2)-levelWid, sandHeight+i, (2*levelWid), 50, 20);
      levelWid+=25;
    }
    if (peakWidth > 5 && sandHeight > 200){
      peakWidth-=1.25;
      sandHeight-=2.5;
      if (sandHeight < 350) {
        textSize(40);  fill(178, 34, 34);//fire brick
        text(toString(), getMapX(), getMapY());
      }
    } else {
      textSize(40);  fill(178, 34, 34);//fire brick
      text(toString(), getMapX(), getMapY());
      fill(220, 20, 60);//crimson
      text("drowning in sand", getMapX()-82, (height/2)+100);
    }
    if (help) p.remainsDisplay();
  }
  
  void keyHandler(int code){
    if (code == 72){//H for help
      help = !help;
      //System.out.println("help toggled");
    }
  }
  
  void mouseHandler(){
  }

  void mousePressedHandler(){
  }

  void mouseReleasedHandler(){
  }
  
}
