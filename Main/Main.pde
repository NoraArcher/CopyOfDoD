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
  activeSet = scenes.get(0);
  DIG = new DigButton((width/2)+60, height-60);
  MAP = new MapButton((width/2)-75, height-60);
}

void draw(){
  activeSet.display();
  showClock();
  if (!tasking) {
    pc.display();
    if (!(DIG.isActive())) {
      //print("DIG is inactive.");
      if (DIG.clicked(scenes, pc) >= 0) DIG.setActive(true);
    }//this does slow down draw significantly
    DIG.display();
    MAP.display();
  }
  if (activeSet.isFinished()) tasking = false;
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
  println(seconds);
  String out = "";
  if (minutes < 10) out += "0";
  out += minutes + ":";
  if (seconds < 10) out += "0";
  out += seconds;
  return out;
}





void keyPressed(){
  if (!tasking){
    pc.move(keyCode);
  }
}

void mousePressed(){
  if (!tasking){
    //button work
    if (dist(DIG.getX(),DIG.getY(),mouseX,mouseY)<60){
      int NewSet = DIG.clicked(scenes, pc);
      if (NewSet > 0) {
        activeSet = scenes.get(NewSet);
        tasking = true;
      }
    } else if (dist(MAP.getX(),MAP.getY(),mouseX,mouseY)<75){
      MAP.clicked();
    }
  } else {
    activeSet.gameplay();
  }
}
