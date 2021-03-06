import java.util.Objects;
public class AssembleArtifactScene extends Scene {
  
  private UrnShard[] shards;
  private UrnShard lastSelected, lastDeselected;
  private PImage fullUrn;
  private int endCount;
  //private float super.mapX, super.mapY; (from Scene)
  //private boolean super.finished;
  //private String name;
  
  AssembleArtifactScene(){
    super(600, 165, "Assemble Artifact");
    shards = new UrnShard[5];
    int destX = (width/2)-(384/2);  int destY = (height/2)-(512/2);
    int lCol = (75+135); int rCol = width-(75+135);//these are vis values
    shards[0] = new UrnShard(150, 100, rCol-160, 380-100, destX,destY,"shard0.png");  shards[0].flip();//shifted this to fit the screen better
    shards[1] = new UrnShard(235, 165, rCol-245, 555-150, destX,destY,"shard1.png");///SHIFTED SO SPOT IS ON SHARD PIMAGE
    shards[2] = new UrnShard( 96, 220, rCol- 96, 205-220, destX,destY,"shard2.png");
    shards[3] = new UrnShard(255, 300, lCol-155, 300-300, destX,destY,"shard3.png");  shards[3].flip();
    shards[4] = new UrnShard(175, 405, lCol-175, 500-405, destX,destY,"shard4.png");
    lastSelected = shards[0];
    lastDeselected = null;
    fullUrn = loadImage("shardsAll.png");
    endCount=0;
  }
  
  void display(){
    background(206, 172, 65);
    stroke(84,105,120); strokeWeight(8);//dark blue
    fill(0,137,137);//medium blue
    rect(75, 125, width-150, height-250, 10);
    noStroke();
    fill(208,93,71);//star fish color
    rect((width/2)-192, 125, 384, 40);
    rect((width/2)-192, height-165, 384, 40);
    stroke(154,108,99,250);  strokeWeight(3);
    line((width/2)-192, 125, (width/2)-192, height-165);
    line((width/2)+192, 125, (width/2)+192, height-165);
    for (UrnShard s : shards){
      s.display();
    }
    if (endCount == 0){
      fill(84,105,120);//dark blue
      textSize(30);
      text("Click D to deselect a piece", 310, 95);
      text("Click F to flip a piece", 350, height-75);
      textSize(23);  fill(84,105,120,180);
      text("Hint: flipping can also separate a clump of pieces", 250, height-45);
    } else if (endCount > 0) {
      if (endCount > 80){
        fill(0,137,137);
        rectMode(CORNERS);
        rect((width/2)-192, 145, (width/2)+192, height-165);
        rectMode(CORNER);
        fill(208,93,71);//star fish color base
        rect((width/2)-192, height-165, 384, 40);
        image(fullUrn, (width/2)-(384/2)+15, (height/2)-(512/2));
      }
      endCount++;
      if (endCount > 170) super.finished = true;
    }
  }
  
  void keyHandler(int code){
    if (code == 70){//F
      lastSelected.flip();
    } else if (code == 68){//D
      lastSelected.setDeselected(true);
      lastDeselected = lastSelected;
    }
  }
  
  void mouseHandler(){
    for (UrnShard s : shards){
      if (!s.isSettled()) {
        if (!s.isDeselected() && s.move()) {
          lastSelected = s;
          s.settle();//to see if it found its destination
        }
        if (!Objects.isNull(lastDeselected) && lastSelected != lastDeselected){
          lastDeselected.setDeselected(false);
          lastDeselected = null;
        }
      }
      //^for loop content
    }//end of for loop
    if (endCount == 0 && allRight()) {
      endCount=1;
    }
  }

  void mouseReleasedHandler() {
    
  }

  void mousePressedHandler() {
    
  }
  
  boolean allRight(){//true when every element of shards is settled, 
  //and their flipped values are the same
    boolean allSettled = true;
    boolean ans = true;
    boolean consistentF = shards[0].isFlipped();
    for (UrnShard s : shards){
      if (!s.isSettled() || s.isFlipped()!=consistentF) ans=false;
      if (!s.isSettled()) allSettled=false;
    }
    if (!ans && allSettled){
      for (UrnShard s : shards){
        s.unsettleShard(2.5);
      }
    }//restart button?
    return ans;
  }
  
}

private class UrnShard extends DraggableObject {
  
  //private float super.x, super.y, super.xFinal, super.yFinal; (from Draggable)
  private float visX, visY, shiftX, shiftY;
  private PImage fragment;
  private boolean flipped, deselected;
  
  UrnShard(int sX, int sY, int x1, int y1, int x2, int y2, String png){
    shiftX = sX;        shiftY = sY;
    super.x = x1;       super.y = y1;
    visX = x1+shiftX;   visY = y1+shiftY;
    super.xFinal = x2;  super.yFinal = y2;
    super.settled = false;
    flipped = false;  deselected = false;
    fragment = loadImage(png);
  }
  
  void display(){
    if (flipped) {
      image(fragment, super.x-384, super.y);
    } else {
      image(fragment, super.x, super.y);
    }
    if (!super.settled){
      stroke(154,108,99,200);  strokeWeight(4);
      fill(180,132,13);//midbrown
      circle(visX, visY, 20);//temporary marker
    }
  }
  
  boolean move(){//called in corresponding-Scene gameplay
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
    PImage resultant = fragment.copy();
    for (int i = 0; i < fragment.width; i++){
      for (int j = 0; j < fragment.height; j++){
        resultant.set(i, j, fragment.get(fragment.width-1-i, j));
      }
    }
    if (flipped) {
      super.x-=384;
      super.xFinal-=384;
    } else {
      super.x+=384;
      super.xFinal+=384;
    }
    shiftX*=-1;
    visX = super.x+shiftX;
    fragment = resultant;
    flipped = !flipped;
  }
  
  boolean isFlipped(){
    return flipped;
  }
  
  void unsettleShard(float ent){
    super.unsettle(ent);
    if (super.x+shiftX < visX) {
      super.x-=90;
    } else if (super.x+shiftX > visX){
      super.x+=90;
    }
    if (super.y+shiftY < visY) {
      super.y+=60;
    } else if (super.y+shiftY > visY){
      super.y-=60;
    }
    visX = super.x+shiftX;
    visY = super.y+shiftY;
  }
  
  boolean isDeselected(){
    return deselected;
  }
  
  void setDeselected(boolean a){
    deselected = a;
  }
  
}
