public abstract class DraggableObject{
  
  private float x, y, xFinal, yFinal;
  private boolean settled;
  
  abstract void display();

  DraggableObject() {}; // in case it's not used
  DraggableObject(int x, int y, int xFinal, int yFinal) {
    this.x = x;
    this.y = y;
    this.xFinal = xFinal;
    this.yFinal = yFinal;
    settled = false;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getXFinal() {
    return xFinal;
  }

  float getYFinal() {
    return yFinal;
  }
  
  void settle(){
    if (dist(x,y,xFinal,yFinal)<30){
      x = xFinal;
      y = yFinal;//should try to move towards the right spot
      //but for now teleportation is good enough
      settled = true;
    }
  }
  
  boolean move(){//called in corresponding-Scene gameplay, called in draw()
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

  void setSettled(boolean settled) {
    this.settled = settled;
  }

  void setCoords(float x, float y, float xFinal, float yFinal) {
    this.x = x;
    this.y = y;
    this.xFinal = xFinal;
    this.yFinal = yFinal;
  }

  void setCoords(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void unsettle(float entropy){
    if (settled){
      settled = false;
      if (x > width/2) {
        x-=(entropy*40);
      } else {
        x+=(entropy*40);
      }
      if (y > height/2) {
        y-=(entropy*40);
      } else {
        y+=(entropy*40);
      } 
    }
  }
  
}
