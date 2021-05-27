public class MainMapScene extends Scene{
  
  private color[] palette;
  
  MainMapScene(){
    super.mapX = 0;
    super.mapY = 0;
    super.isFinished = false;

    palette = new color[5];
    palette[4] = color(168, 101, 30);//dark brown
    palette[3] = color(239, 222, 194);//pale sand
    palette[2] = color(215, 175, 114);//light brown, usable for detailing?
    palette[1] = color(218, 194, 124);//light sand
    palette[0] = color(206, 172, 65);//dark sand
  }
  
  void display(){
    background(palette[0]);
    strokeWeight(9);
    fill(palette[1]);
    stroke(palette[4]);
    rect(75, 125, width-150, height-250, 10);
    noFill();
    rect(width/4, 125, 120, 90);//licensing check in
    rect((75+width/5), height-250, 400, 70);//path to item storage
    fill(palette[3]);
    rect(75, height-375, width/5, 250);//item storage
    fill(palette[0]);
    
    //noFill();
    strokeWeight(5);
    line((width/2), 150, width-75-55, 150);//ropes off different digs
    line((width/2), 280, width-75-55, 280);
    line(width-75-55, 150, width-75-55, 280);
    
    line((width/2)-100, 350, width-75-145, 350);
    line((width/2)-100, 460, width-75-145, 460);
    line((width/2)-100, 350, (width/2)-100, 460);
    
    noStroke();
    rect(75+45, 125-40, 85, 120);//stairs
    stroke(palette[4]);
    strokeWeight(3);  //steps below
    line(75+45, 125+4, 75+130, 125+4);
    line(75+45, 125+19, 75+130, 125+19);
    line(75+45, 125+34, 75+130, 125+34);
    line(75+45, 125+49, 75+130, 125+49);
    line(75+45, 125+64, 75+130, 125+64);
  }
  
  void keyHandler(int code) {
    
  }
  
  void mouseHandler(int x, int y) {
    
  }
  
}
