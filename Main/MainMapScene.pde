public class MainMapScene extends Scene{
  
  //private Button DIG;
  //private Button MAP;
  
  MainMapScene(){
    super.mapX = width/2;
    super.mapY = height/2;
    super.isFinished = false;
  }
  
  void display(){
    background(240, 230, 140);//khaki
    strokeWeight(9);
    noFill();
    stroke(164, 90, 7);//brown
    rect(75, 125, width-150, height-225, 10);
  }
  
  void gameplay(){
    //use of buttons
    System.out.print("Hello World");
  }
  
}
