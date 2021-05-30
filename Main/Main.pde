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
  STYLE = new StyleButton(110, 300);
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
      int[] choices = STYLE.clicked(pc);
      if (choices[0] >= -1) {//-1 is no hat, 1+ are hats
        pc.setHat(choices[0]);
      }
      if (choices[1] >= 0) {
        pc.setColor(choices[1]);
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

private class DigButton extends Button{
  
  //int super.x, super.y;
  //boolean super.active, super.selected;

  DigButton(int a, int b){
    super.x = a;
    super.y = b;
    super.active = false;
  }
  
  void display(){
    int opacity = 200;
    stroke(169);
    if (super.active){
      opacity = 250;
      stroke(0);
    }
    strokeWeight(5);
    fill(178, 186, 187, opacity);//DarkGray
    rect(x-60, y-40, 120, 80);
    fill(211, 84, 0, opacity);//OrangeyBrown
    textSize(60);
    text("DIG", x-52, y+20);
  }
  
  void clicked(){//implemented differently than in abstract outline
  }
  
  int clicked(ArrayList<Scene> sets, Player m){
    //print("dig away?");
    Scene c;
    int answer = -1;
    active = false;
    for (int i = 1; i < sets.size(); i++){//change to size()-2 when Defeat+Victry are added
      c = sets.get(i);
      if (!c.isFinished() && dist(c.getMapX(),c.getMapY(),m.getX(),m.getY()) < (m.getRadius()*7/5.0)){
        answer = i;
        active = true;
      }
    }
    return answer;
  }
  
}

private class MapButton extends Button {
  
  //int super.x, super.y;
  //boolean super.active, super.selected;

  MapButton(int a, int b){
    super.x = a;
    super.y = b;
    super.selected = false;
  }
  
  void display(){//implemented differently than in abstract outline
  }
  
  void display(ArrayList<Scene> sets){
    int opacity = 250;
    
    if (selected) {
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
    selected = !selected;
  }
  
}

private class StyleButton extends Button {
  //int super.x, super.y;
  //boolean super.active, super.selected;
  int indexusH, indexusC;
  
  StyleButton(int a, int b){
    super.x = a;
    super.y = b;
    super.active = false;
    indexusH = 0;//first hat
    indexusC = 0;
  }
  
  void display(){
    fill(163); strokeWeight(2); stroke(50);
    if (active) {
      stroke(255, 255, 0);
      strokeWeight(3);
    }
    rect(super.x-10,super.y-25,20,50);
  }
  
  void activate(Player sir){
    active = false;
    if ( dist(super.x,super.y,sir.getX(),sir.getY()) < (sir.getRadius()*6/5.0) ){
      active = true;
    }
  }
  
  void clicked(){}//implemented differently than in abstract outline
  
  int[] clicked(Player sir){
    int[] answer = {-2, -1};
    if (active){
      answer = new int[]{indexusH, indexusC};
      indexusH++;
      if (indexusH >= sir.getHats().length) {
        indexusH = -1;
        indexusC++;
        if (indexusC >= sir.getHues().length) indexusC = 0;
      }
    }
    return answer;
  }
  
}//end of class
