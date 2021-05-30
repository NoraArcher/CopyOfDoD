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
Player PC;

/** Sets up the game */
void setup() {
  size(1000, 800);
  tasking = false;
  PC = new Player(75+90, 125+70);

  setupScenes();
  setupButtons();
}

/** Initializes all scenes */
void setupScenes() {
  scenes = new ArrayList<Scene>();

  // ALL SCENES ADDED HERE
  scenes.add(new MainMapScene());
  scenes.add(new AssembleArtifactScene());
  //next task
  //scenes.add(new DefeatScene());
  //scenes.add(new VictoryScene());

  activeSet = scenes.get(0);
}

/** Initializes all buttons */
void setupButtons() {
  DIG = new DigButton((width/2)+60, height-60);
  MAP = new MapButton((width/2)-80, height-60);
  STYLE = new StyleButton(110, 300);
}

/** Loops continuously - displays clock, current scene, and buttons */
void draw() {
  activeSet.display();

  if (allFinished()) {
    // activeSet = VictoryScene; // ^ same with VictoryScene
  } else if (getRemainingTime() < 0) {
    // activeSet = DefeatScene; // DefeatScene's finished value is always false
  } else {
    showClock();
  }

  if (!tasking) {
    PC.display();
    if (DIG.clicked(scenes, PC) > 0) {};//this will check and change active all at once
    STYLE.activate(PC);//(similar use to above)
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

/** Displays the clock with the remaining time */
void showClock() {
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

/** Returns the remaining time in milliseconds */
float getRemainingTime() {
  float a = ALLOTTED_TIME - (millis() - startTime);
  if (a > 0.0) return a;
   return 0.0;
}

/** Formats the remaining time into a string in form MM:SS */
String formattedTime(int minutes, int seconds) {
  String out = "";
  if (minutes < 10) out += "0";
  out += minutes + ":";
  if (seconds < 10) out += "0";
  out += seconds;
  return out;
}

// GAMEPLAY

/** Handles key presses - moves PC or calls keyHandler of activeSet */
void keyPressed() {
  if (!tasking) {
    PC.move(keyCode);
  } else {
    activeSet.keyHandler(keyCode);
  }
}

/** Handles button presses in main map */
void mousePressed() {
  if (!tasking) {
    // DIG
    if (dist(DIG.getX(), DIG.getY(), mouseX, mouseY) < 60 && DIG.isActive()) {
      int NewSet = DIG.clicked(scenes, PC);
      if (NewSet > 0) {
        activeSet = scenes.get(NewSet);
        tasking = true;
      }
    }

    // MAP
    else if (dist(MAP.getX(), MAP.getY(), mouseX, mouseY) < 75) {
      MAP.clicked();
    }

    // STYLE
    else if (dist(STYLE.getX(), STYLE.getY(), mouseX, mouseY) < 55) {
      int[] choices = STYLE.clicked(PC);
      if (choices[0] >= -1) PC.setHat(choices[0]);// -1 is no hat, 1+ are hats
      if (choices[1] >= 0) PC.setColor(choices[1]);
    }
    
  }
}

// VICTORY

boolean allFinished() {
  for (int i = 0; i < scenes.size(); i++) {
    //change initial i to 1 when you're ready to add victory
    //once Defeat and VictoryScenes are added make it scenes.size()-2
    if (!scenes.get(i).isFinished()) return false;
  }
  return true;
}


// BUTTONS

private class DigButton extends Button {
  DigButton(int a, int b) {
    super(a, b);
  }
  
  void display() {
    int opacity = 200;
    stroke(169);
    if (isActive()){
      opacity = 250;
      stroke(0);
    }
    strokeWeight(5);
    fill(178, 186, 187, opacity); // DarkGray
    rect(getX()-60, getY()-40, 120, 80);
    fill(211, 84, 0, opacity); // OrangeyBrown
    textSize(60);
    text("DIG", getX()-52, getY()+20);
  }
  
  int clicked(ArrayList<Scene> sets, Player p){
    Scene c;
    int answer = -1;
    setActive(false);
    for (int i = 1; i < sets.size(); i++){// Change to size()-2 when Defeat+Victory are added
      c = sets.get(i);
      if (!c.isFinished() && dist(c.getMapX(),c.getMapY(),p.getX(),p.getY()) < (p.getRadius()*7/5.0)){
        answer = i;
        setActive(true);
      }
    }
    return answer;
  }
  
}

private class MapButton extends Button {
  MapButton(int a, int b) {
    super(a, b);
  }
  
  // Displays Names of Tasks over their access points on MainMapScene
  void display(ArrayList<Scene> sets) {
    int opacity = 250;
    
    if (isSelected()) {
      opacity = 200;
      //display tasks labels
      textSize(28);
      for (int i = 1; i < sets.size(); i++) {// Change to size()-2 when Defeat+Victry are added
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
    rect(getX()-75, getY()-40, 150, 80);
    fill(203, 67, 53, opacity);//Reddish
    textSize(60);
    text("MAP", getX()-63, getY()+20);
  }
  
  void clicked() {
    toggleSelected();
  }
  
}

private class StyleButton extends Button {
  int indexusH, indexusC;
  
  StyleButton(int a, int b) {
    super(a, b);
    indexusH = 0; // first hat
    indexusC = 0; // initial color
  }
  
  void display() {
    fill(163); strokeWeight(2); stroke(50);
    if (isActive()) {
      stroke(255, 255, 0);
      strokeWeight(3);
    }
    rect(getX()-10, getY()-25, 20, 50);
  }
  
  void activate(Player sir) {
    setActive(false);
    if (dist(getX(), getY(), sir.getX(), sir.getY()) < (sir.getRadius()*6/5.0)) {
      setActive(true);
    }
  }
  
  int[] clicked(Player sir) {
    int[] answer = {-2, -1};
    if (isActive()) {
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
  
}
