public class Player{
  
  private float x, y, r;
  private color c;
  private int hatIndex;
  private ArrayList<Hat> toppings;
  
  
  Player(float a, float b){
    x = a;
    y = b;
    r = 50.0;
    c = color(188, 143, 143);//purple
    hatIndex = -1;
    toppings = new ArrayList<Hat>();
    toppings.add(new CatEarsHat(r));
    toppings.add(new HardHat(r));
    toppings.add(new BowlerHat(r));
    hatIndex = 1;
  }
  
  void display(){
    if (hatIndex==0) toppings.get(hatIndex).display((int)x,(int)y);
    fill(c);
    stroke(142,86,30);  strokeWeight(2);//outline color
    ellipse(x, y, r, (r*3/2.0));//torso
    stroke(218, 194, 124);  strokeWeight(4);//floor color
    line(x, y+18, x, y+(r*3/4.0));//thigh gap
    stroke(142,86,30);  strokeWeight(2);//outline color
    line(x+3, y+18, x+3, y+(r*3/4.0));//leg split
    line(x-3, y+18, x-3, y+(r*3/4.0));//leg split
    circle(x-((r/2)+3),y+12,(r/4.0));  circle(x+((r/2)+3),y+12,(r/4.0));//hands
    //draw visor
    rectMode(CENTER);
    fill(250, 240, 230);//linen
    //System.out.print("visor");
    rect(x, y-7, r*(2.0/3), r/3.0, 5);
    //not sure why this ^ isn't showing up
    rectMode(CORNER);
    if (hatIndex > 0) toppings.get(hatIndex).display((int)x,(int)y);
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
  
  String[] getHats(){
    String[] answer = new String[toppings.size()];
    for (int i = 0; i < answer.length; i++){
      answer[i] = toppings.get(i).toString();
    }
    return answer;
  }
  
  void setHat(int i){
    hatIndex = i;
  }
  
  void setColor(color hue){
    c = hue;
  }
 
}//end of class


private abstract class Hat{
  private float r;
  private color c;
  private String name;
  abstract void display(int a, int b);
  String toString(){
    return name;
  }
}

private class CatEarsHat extends Hat{
  CatEarsHat(float z){
    super.r = z;  super.c = color(0,0,0);  super.name = "Cat Ears";
  }
  void display(int a, int b){
    fill(super.c);  stroke(100);  strokeWeight(2);
    triangle(a-(super.r*3/6.0), b-(super.r*9/10.0),//outerest point
             a-(super.r*7/15.0),   b-(super.r*3/6.0),//lowest point
             a-(super.r/7.0),   b-(super.r*11/15.0));//innerest point
    triangle(a+(super.r*3/6.0), b-(super.r*9/10.0),
             a+(super.r*7/15.0),   b-(super.r*3/6.0),
             a+(super.r/7.0),   b-(super.r*11/15.0));
  }
}

private class HardHat extends Hat{
  HardHat(float z){
    super.r = z;  super.c = color(255, 215, 0);  super.name = "Hard Hat";
  }
  void display(int a, int b){
    fill(super.c);  stroke(240, 230, 140);  strokeWeight(2);//fillgold,linekhaki
    ellipse(a, b-(super.r*3/5.0), (super.r*4/5.0), (super.r/5.0));
    arc(a, b-(super.r*3/5.0), (super.r*3/5.0), (super.r*2/3.0), PI, 2*PI, OPEN);
    fill(255);  stroke(180);
    circle(a, b-(super.r*3/5.0), 9);
  }
}

private class BowlerHat extends Hat{
  BowlerHat(float z){
    super.r = z;  super.c = color(0);  super.name = "Bowler Hat";
  }
  void display(int a, int b){
    fill(super.c);  stroke(100);  strokeWeight(2);
    ellipse(a, b-(super.r*3/5.0), (super.r), (super.r/2.0));
    arc(a, b-(super.r*3/5.0), (super.r*3/5.0), (super.r*2/3.0), PI, 2*PI, OPEN);
  }
}
