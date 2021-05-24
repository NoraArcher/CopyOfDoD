public class Player{
  
  int x, y, r;
  
  Player(int a, int b){
    x = a;
    y = b;
    r = 60;
  }
  
  void display(){
    fill(188, 143, 143);//purple
    ellipse(x, y, r, (r*3/2));
    //draw visor
    rectMode(CENTER);
    fill(250, 240, 230);//linen
    rect(x, y, r*(2/3), r/3, 5);
    //not sure why this ^ isn't showing up
    rectMode(CORNER);
  }
  
  void move(int code){
    if (code == 87){//W
      y-=20;
    } else if (code == 65){//A
      x-=20;
    } else if (code == 83){//S
      y+=20;
    } else if (code == 68){//D
      x+=20;
    }
  }
 
}
