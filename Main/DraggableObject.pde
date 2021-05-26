public abstract class DraggableObject{
  
  private int x, y, xFinal, yFinal;
  
  abstract void display();
  
  void settle(){
    if ((x < xFinal+15 && x > xFinal-15) && 
        (y < yFinal+15 && y > yFinal-15)){
      x = xFinal;
      y = yFinal;//should try to move towards the right spot
      //but for now teleportation is good enough
    }
  }
  
  void move(){//called in corresponding-Scene gameplay, called in mousePressed
    if ((x < mouseX+5 && x > mouseX-5) && 
        (y < mouseY+5 && y > mouseY-5)){//to establish that you're clicking on this
      x = mouseX;
      y = mouseY;
    }
  }
  
  
}
