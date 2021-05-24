float time;
boolean tasking;
Player mp;

void setup(){
  size(1000, 800);
  strokeWeight(9);
  noFill();
  stroke(164, 90, 7);//brown
  rect(100, 100, width-200, height-200, 10);
  time = 0.0;
  tasking = false;
  mp = new Player(width/3, height/4);
  
}

void draw(){
  background(240, 230, 140);//khaki
  strokeWeight(9);
  noFill();
  stroke(164, 90, 7);//brown
  rect(100, 100, width-200, height-200, 10);
  noStroke();
  fill(250, 0, 0);
  textSize(30);
  int hour = (int)((720-time)/60);
  int minute = (int)((720-time)%60);
  text(hour+":"+minute, width-100, 50);
  if (!tasking) {
    mp.display();
  }
  time += 0.005;
}

void keyPressed(){
  if (!tasking){
    mp.move(keyCode);
  }
}

void mousePressed(){
  if (!tasking){
    //can click DIG button
  } else {
    //works differently in all tasks, should be able to
    //draw objects across screen generally
  }
}
