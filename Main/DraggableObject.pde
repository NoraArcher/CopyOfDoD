public abstract class DraggableObject{
  
  private float x, y, xFinal, yFinal;
  private boolean settled;
  
  abstract void display();
  
  void settle(){
    if (dist(x,y,xFinal,yFinal)<30){
      x = xFinal;
      y = yFinal;//should try to move towards the right spot
      //but for now teleportation is good enough
      settled = true;
    }
  }
  
  boolean move(){//called in corresponding-Scene gameplay, called in mousePressed
    if (dist(x,y,mouseX,mouseY)<50){//to establish that you're clicking on this
      x = mouseX;
      y = mouseY;
      return true;
    }
    return false;
  }
  
  boolean isSettled(){
    return settled;
  }
  
}
