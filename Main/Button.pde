public abstract class Button {
  
  private int x, y;
  private boolean active;
  
  abstract void display();//to be called in mainmapscene display?
  
  boolean isActive(){
    return active;
  }
  
  void setActive(boolean a){
    active = a;
  }
  
}
