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
}

void draw(){
  activeSet.display();
  if (getRemainingTime() <= 0) {
    //activeSet = DefeatScene; //DefeatScene's finished value is always false
  } else if (allFinished()) {
    //activeSet = VictoryScene; //^ same with VictoryScene
  }else {
    showClock();
  }
  if (!tasking) {
    pc.display();
    if (DIG.clicked(scenes, pc) > 0) {//>0 b/c returning 0 would mean the task is main map
      DIG.setActive(true);
    } else {//does slow down draw by calling DIG.clicked so often
      DIG.setActive(false);
    }
    DIG.display();
    //MAP.display();
    MAP.display(scenes);
  }
  if (activeSet.isFinished()) {
    tasking = false;
    activeSet = scenes.get(0);
  }
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
   return ALLOTTED_TIME - (millis() - startTime);
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

void mousePressed(){
  if (!tasking){
    //button work
    if (dist(DIG.getX(),DIG.getY(),mouseX,mouseY)<60 && DIG.isActive()){
      int NewSet = DIG.clicked(scenes, pc);
      if (NewSet > 0) {
        activeSet = scenes.get(NewSet);
        tasking = true;
        //DIG is still displaying active during tasks >:|
      }
    } else if (dist(MAP.getX(),MAP.getY(),mouseX,mouseY)<75){
      MAP.clicked();
    }
  } else {
    activeSet.mouseHandler(mouseX, mouseY);
  }
}

//VICTORY

boolean allFinished(){
  for (int i = 1; i < scenes.size(); i++){
    //once Defeat and VictoryScenes are added make it scenes.size()-2
    if (!scenes.get(i).isFinished()) return false;
  }
  return true;
}
