public abstract class Button {
  int x,y;
  boolean active;
  
  abstract void display();
  abstract void clicked();
  
  float getX(){
    return x;
  }
  
  float getY(){
    return y;
  }
  
  void setActive(boolean a){
    active = a;
  }
  
  boolean isActive(){
    return active;
  }
  
}
