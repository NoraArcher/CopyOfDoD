float time;
boolean tasking;
ArrayList<Scene> scenes;
Scene activeSet;
Player pc;
DigButton DIG;
MapButton MAP;

void setup(){
  size(1000, 800);
  time = 0.0;
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
  clock();
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

void clock(){
  stroke(0);
  strokeWeight(2);
  fill(250);
  rect(width-150, 20, 130, 70, 10);
  noStroke();
  fill(250, 0, 0);
  textSize(30);
  int hour = (int)((360-time)/60);
  int minute = (int)((360-time)%60);
  String a = ""+hour;  String b =""+minute;
  if(hour<10) a="0"+a;
  if(minute<10) b="0"+b;
  text(a+":"+b, width-125, 65);
  time += 0.005;
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
