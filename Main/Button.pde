public class Button {
  private int x, y;
  private boolean active, selected; // active is clickable, selected is clicked

  Button(int x, int y) {
    this.x = x;
    this.y = y;
    active = false;
    selected = false;
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  void setActive(boolean a) {
    active = a;
  }
  
  void setSelected(boolean a) {
    selected = a;
  }

  void toggleSelected() {
    selected = !selected;
  }
  
  boolean isActive() {
    return active;
  }

  boolean isSelected() {
    return selected;
  }
}
