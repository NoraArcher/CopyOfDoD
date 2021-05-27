public abstract class DraggableObject{
  
  private float x, y, xFinal, yFinal;
  
  abstract void display();
  
  void settle(){
    if (dist(x,y,xFinal,yFinal)<30){
      x = xFinal;
      y = yFinal;//should try to move towards the right spot
      //but for now teleportation is good enough
    }
  }
  
  void move(){//called in corresponding-Scene gameplay, called in mousePressed
    if (dist(x,y,mouseX,mouseY)<30){//to establish that you're clicking on this
      x = mouseX;
      y = mouseY;
    }
  }
  
  
}
