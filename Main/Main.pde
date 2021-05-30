// TIME
float startTime;
final float ALLOTTED_TIME = 300000; // 5 mins

// SCENE HANDLING
ArrayList<Scene> scenes;
Scene activeSet;
boolean tasking;

// BUTTONS
DigButton DIG;
MapButton MAP;
StyleButton STYLE;

// PLAYER
Player pc;

void setup(){
  size(1000, 800);
  tasking = false;
  pc = new Player(75+90, 125+70);
  scenes = new ArrayList<Scene>();
  scenes.add(new MainMapScene());
  scenes.add(new AssembleArtifactScene());
  //all tasks added here
  //scenes.add(new DefeatScene());
  //scenes.add(new VictoryScene());
  activeSet = scenes.get(0);
  DIG = new DigButton((width/2)+60, height-60);
  MAP = new MapButton((width/2)-80, height-60);
  STYLE = new StyleButton(100, 275);
}

void draw(){
  activeSet.display();
  if (allFinished()) {
    //activeSet = VictoryScene; //^ same with VictoryScene
  } else if (getRemainingTime() < 0) {
    //activeSet = DefeatScene; //DefeatScene's finished value is always false
  } else {
    showClock();
  }
  if (!tasking) {
    pc.display();
    if (DIG.clicked(scenes, pc) > 0) {};//this will check and change active all at once
    STYLE.activate(pc);//(similar use to above)
    DIG.display();
    //MAP.display();
    MAP.display(scenes);
    STYLE.display();
  }
  if (activeSet.isFinished()) {
    tasking = false;
    activeSet = scenes.get(0);
  }
  activeSet.mouseHandler();
}

// TIME

void showClock(){
  stroke(0);
  strokeWeight(2);
  fill(250);
  rect(width-150, 20, 130, 70, 10);
  noStroke();
  fill(250, 0, 0);
  textSize(30);
  
  float remainingTime = getRemainingTime();
  int minutes = (int) remainingTime / 60000;
  int seconds = (int) (remainingTime - (minutes * 60000)) / 1000;

  text(formattedTime(minutes, seconds), width-125, 65);
}

float getRemainingTime() {
  float a = ALLOTTED_TIME - (millis() - startTime);
  if (a > 0.0) return a;
   return 0.0;
}

String formattedTime(int minutes, int seconds) {
  String out = "";
  if (minutes < 10) out += "0";
  out += minutes + ":";
  if (seconds < 10) out += "0";
  out += seconds;
  return out;
}

//GAMEPLAY

void keyPressed(){
  if (!tasking){
    pc.move(keyCode);
  } else {
    activeSet.keyHandler(keyCode);
  }
}

void mousePressed(){//essentially button handler
  if (!tasking){
    //button work
    if (dist(DIG.getX(),DIG.getY(),mouseX,mouseY)<60 && DIG.isActive()){
      int NewSet = DIG.clicked(scenes, pc);
      if (NewSet > 0) {
        activeSet = scenes.get(NewSet);
        tasking = true;
      }
    } else if (dist(MAP.getX(),MAP.getY(),mouseX,mouseY)<75){
      MAP.clicked();
    } else if (dist(STYLE.getX(),STYLE.getY(),mouseX,mouseY)<55) {
      int choice = STYLE.clicked(pc);
      String[] tops = pc.getHats();
      if (choice < tops.length && choice >= -1) {//-1 is no hat, 1+ are hats
        pc.setHat(choice);
      } else if (choice >= tops.length) {
        pc.setColor(choice-tops.length);
      }
    }
  } else {
    //activeSet.mouseHandler(mouseX, mouseY);
  }
}

//VICTORY

boolean allFinished(){
  for (int i = 0; i < scenes.size(); i++){
    //change initial i to 1 when you're ready to add victory
    //once Defeat and VictoryScenes are added make it scenes.size()-2
    if (!scenes.get(i).isFinished()) return false;
  }
  return true;
}


//BUTTONS

private class StyleButton extends Button {
  //int super.x, super.y;
  //boolean super.active, super.selected;
  int indexus;
  
  StyleButton(int a, int b){
    super.x = a;
    super.y = b;
    super.active = false;
    indexus = 0;//this is kind of a terrible system but works for now
  }
  
  void display(){
    fill(163); strokeWeight(3); noStroke();
    if (active) stroke(255, 255, 0);
    rect(super.x,super.y,15,30);
  }
  
  void activate(Player sir){
    active = false;
    if (dist(super.x,super.y,sir.getX(),sir.getY()) < 50){
      active = true;
    }
  }
  
  void clicked(){}//implemented differently than in abstract outline
  
  int clicked(Player sir){
    if (active){
      int temp = indexus;
      indexus++;
      if (indexus >= sir.getOptionCount()) indexus = -1;
      System.out.println(temp);
      return temp;
    }
    return -2;
  }
  
}//end of class
