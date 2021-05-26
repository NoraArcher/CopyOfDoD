float time;
boolean tasking;
ArrayList<Scene> scenes;
Scene activeSet;
Player pc;

void setup(){
  size(1000, 800);
  time = 0.0;
  tasking = false;
  pc = new Player(width/3, height/4);
  scenes = new ArrayList<Scene>();
  scenes.add(new MainMapScene());
  activeSet = scenes.get(0);
}

void draw(){
  activeSet.display();
  clock();
  if (!tasking) {
    pc.display();
  }
}

void clock(){
  stroke(0);
  strokeWeight(2);
  fill(250);
  rect(width-150, 20, 130, 70, 10);
  noStroke();
  fill(250, 0, 0);
  textSize(30);
  int hour = (int)((720-time)/60);
  int minute = (int)((720-time)%60);
  text(hour+":"+minute, width-125, 65);
  time += 0.005;
}

void keyPressed(){
  if (!tasking){
    pc.move(keyCode);
  }
}

void mousePressed(){
  if (!tasking){
    //if dig.isActive() && mouse is clicking dig, tasking! = false and activeSet changes
  } else {
    activeSet.gameplay();
  }
}
