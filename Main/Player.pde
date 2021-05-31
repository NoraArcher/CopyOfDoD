public class Player{
  
  float x, y, r;
  color[] hues;
  int hatIndex, hueIndex;
  ArrayList<Hat> toppings;
  
  Player(float a, float b){
    x = a;
    y = b;
    r = 50.0;
    hues = new color[3];
    hues[0] = color(188, 143, 143);//purple/red
    hues[1] = color(143, 188, 139);//green
    hues[2] = color(137, 162, 194);//blue
    hueIndex = 0;
    hatIndex = -1;
    toppings = new ArrayList<Hat>();
    toppings.add(new CatEarsHat());
    toppings.add(new HardHat());
    toppings.add(new BowlerHat());
  }
  
  void display(){
    if (hatIndex==0) toppings.get(hatIndex).display((int)x,(int)y, r);
    fill(hues[hueIndex]);
    stroke(142,86,30);  strokeWeight(2);//outline color
    ellipse(x, y, r, (r*3/2.0));//torso
    stroke(218, 194, 124);  strokeWeight(4);//floor color
    line(x, y+(r/2.8), x, y+(r*3/4.0));//thigh gap
    stroke(142,86,30);  strokeWeight(2);//outline color
    line(x+3, y+(r/2.8), x+3, y+(r*3/4.0));//leg split
    line(x-3, y+(r/2.8), x-3, y+(r*3/4.0));//leg split
    circle(x-((r/2)+3),y+12,(r/4.0));  circle(x+((r/2)+3),y+12,(r/4.0));//hands
    //draw visor
    rectMode(CENTER);
    fill(250, 240, 230);//linen
    //System.out.print("visor");
    rect(x, y-(r/6.3), r*(2.0/3), r/3.0, 5);
    //not sure why this ^ isn't showing up
    rectMode(CORNER);
    if (hatIndex > 0) toppings.get(hatIndex).display((int)x,(int)y, r);
  }
  
  void move(int code){
    if (code == 87 || code == 38){//W
      if (y > (125+r+4)) {
        y-=20;
      }
    } else if (code == 65 || code == 37){//A
      if (x > (75+r)) {
        x-=20;
      }
    } else if (code == 83 || code == 40){//S
      if (y < (height-125-r)) {
        y+=20;
      }
    } else if (code == 68 || code == 39){//D
      if (x < (width-75-r)) {
        x+=20;
      }
    }
  }//end of move
  
  float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  float getRadius(){
    return r;
  }
  
  ///styling methods
  String[] getHats(){
    String[] answer = new String[toppings.size()];
    for (int i = 0; i < answer.length; i++){
      answer[i] = toppings.get(i).toString();
    }
    return answer;
  }
  color[] getHues(){
    return hues;
  }
  void remainsDisplay(){
    if (hatIndex>=0) {
      toppings.get(hatIndex).display((int)x, (int)y, r);
      //System.out.println("hat out");
    } else {
      fill(hues[hueIndex]);
      stroke(142,86,30);  strokeWeight(2);//outline color
      circle(x-((r/2)+3),y+12,(r/4.0));
      //System.out.println("hand out");
    }
  }
  
  void setHat(int i){
    hatIndex = i;
  }
  void setColor(int i){
    hueIndex = i;
  }
  void setRadius(float factor){
    r=factor;
  }
  void setXY(float ex, float wy){
    x = ex;
    y = wy;
  }
  
 
}//end of class


private abstract class Hat{
  private color c;
  private String name;
  abstract void display(int a, int b, float r);
  String toString(){
    return name;
  }
}

private class CatEarsHat extends Hat{
  CatEarsHat(){
    super.c = color(0,0,0);  super.name = "Cat Ears";
  }
  void display(int a, int b, float r){
    b-=(r*3.0/4);//top of head
    fill(super.c);  stroke(100);  strokeWeight(2);
    triangle(a-(r*3/6.0),    b-(r/6.4),//outerest point
             a-(r*7/15.0),   b+(r*3/10.0),//lowest point
             a-(r/7.0),      b);//innerest point
    triangle(a+(r*3/6.0),    b-(r/6.4),
             a+(r*7/15.0),   b+(r*3/10.0),
             a+(r/7.0),      b);
  }
}

private class HardHat extends Hat{
  HardHat(){
    super.c = color(255, 215, 0);  super.name = "Hard Hat";
  }
  void display(int a, int b, float r){
    b-=(r*3.0/4);//top of head
    fill(0);  circle(a, b, 10);
    fill(super.c);  stroke(240, 230, 140);  strokeWeight(2);//fillgold,linekhaki
    ellipse(a, b+(r/6.0), (r*14/15.0), (r/5.0));
    arc(a, b+(r/6.0), (r*7/10.0), (r*7/9.0), PI, 2*PI, OPEN);
    fill(255);  stroke(180);
    circle(a, b+(r/6.0), r/6);
  }
}

private class BowlerHat extends Hat{
  BowlerHat(){
    super.c = color(0);  super.name = "Bowler Hat";
  }
  void display(int a, int b, float r){
    b-=(r*3.0/4);//top of head
    fill(super.c);  stroke(100);  strokeWeight(2);
    ellipse(a, b+(r/7.0), r, (r/2.0));
    arc(a, b+(r/7.0), (r*3/5.0), (r*2/3.0), PI, 2*PI, OPEN);
  }
}
