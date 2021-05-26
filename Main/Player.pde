public class Player{
  
  float x, y, r;
  color c;
  
  Player(float a, float b){
    x = a;
    y = b;
    r = 50.0;
    c = color(188, 143, 143);//purple
  }
  
  void display(){
    fill(c);
    ellipse(x, y, r, (r*3/2));
    //draw visor
    rectMode(CENTER);
    fill(250, 240, 230);//linen
    //System.out.print("visor");
    rect(x, y-7, r*(2.0/3), r/3.0, 5);
    //not sure why this ^ isn't showing up
    rectMode(CORNER);
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
      if (y < (height-100-r)) {
        y+=20;
      }
    } else if (code == 68 || code == 39){//D
      if (x < (width-75-r)) {
        x+=20;
      }
    }
  }//end of move
 
}//end of class
