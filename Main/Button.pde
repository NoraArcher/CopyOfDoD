public abstract class Button {
  int x,y;
  boolean active, selected;//active is clickable, selected is clicked
  
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
  
  void setSelected(boolean a){
    selected = a;
  }
  
  boolean isActive(){
    return active;
  }
  
}
