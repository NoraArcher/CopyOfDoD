public class AssembleArtifactScene extends Scene {
  
  UrnShard[] shards;
  UrnShard lastSelected;
  //private float super.mapX, super.mapY; (from Scene)
  //private boolean super.isFinished;
  
  AssembleArtifactScene(){
    super.mapX = (width/2);
    super.mapY = 200;
    super.isFinished = false;
    shards = new UrnShard[5];
    int destX = (width/2)-(384/2);  int destY = (height/2)-(512/2);
    int lCol = (75+55); int rCol = width-(75+55);//these are vis values
    shards[0] = new UrnShard(150, 100, rCol-150, 425-100, destX,destY,"shard0.png");
    shards[1] = new UrnShard(245, 150, lCol-245, 595-150, destX,destY,"shard1.png");
    shards[2] = new UrnShard( 96, 220, rCol- 96, 225-220, destX,destY,"shard2.png");
    shards[3] = new UrnShard(255, 300, lCol-255, 395-300, destX,destY,"shard3.png");
    shards[4] = new UrnShard(185, 405, lCol-185, 195-405, destX,destY,"shard4.png");
    lastSelected = shards[0];
  }
  
  void display(){
    background(206, 172, 65);
    fill(0,137,137);//blue
    rect(75, 125, width-150, height-250, 10);
    //text("Click F to flip a piece", 0, height);
    for (UrnShard s : shards){
      s.display();
      //s.settle();//to see if they're done?
    }
  }
  
  void keyHandler(int code){
    if (code == 70){//F
      lastSelected.flip();
    }
  }
  
  void mouseHandler(int x, int y){
    for (UrnShard s : shards){
      if (!s.isSettled()) {
        if (s.move()) {
          lastSelected = s;
          s.settle();//to see if it found its destination
        }
      }
      //^for loop content
    }//end of for loop
    //when every element of shards is settled, and their flipped values 
    //are the same, THEN super.isFinished = true;
  }  
  
}

private class UrnShard extends DraggableObject {
  
  //private float super.x, super.y, super.xFinal, super.yFinal; (from Draggable)
  private float visX, visY, shiftX, shiftY;
  private PImage fragment;
  private boolean flipped;
  
  UrnShard(int sX, int sY, int x1, int y1, int x2, int y2, String png){
    shiftX = sX;        shiftY = sY;
    super.x = x1;       super.y = y1;
    visX = x1+shiftX;   visY = y1+shiftY;
    super.xFinal = x2;  super.yFinal = y2;
    super.settled = false;
    fragment = loadImage(png);
  }
  
  void display(){
    image(fragment, super.x, super.y);
    if (!super.settled){
      fill(180,132,13);
      circle(visX, visY, 20);//temporary marker
    }
  }
  
  boolean move(){//called in corresponding-Scene gameplay, called in mousePressed
    if (dist(visX,visY,mouseX,mouseY)<50){
      //to establish that you're clicking on this piece
      visX = mouseX;
      visY = mouseY;
      super.x = mouseX-shiftX;
      super.y = mouseY-shiftY;
      return true;
    }
    return false;
  }
  
  void flip(){
    flipped = !flipped;//not completed...
  }
  
  boolean isFlipped(){
    return flipped;
  }
  
}
