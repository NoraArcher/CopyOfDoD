public abstract class Scene {
  
  private float mapX, mapY;
  private boolean finished;
  //private int endCount;//for ending 'animations', see AAScene for an example
  private String name;

  Scene(int mapX, int mapY, String name) {
    this.mapX = mapX;
    this.mapY = mapY;
    finished = false;
    this.name = name;
  }
  
  abstract void display();//to be called in draw
  
  void display(Player p){
    p.display();//here so Victory and Defeat can override it
  }
  
  abstract void keyHandler(int code);
  
  abstract void mouseHandler();

  abstract void mousePressedHandler();

  abstract void mouseReleasedHandler();
  
  float getMapX(){
    return mapX;
  }
  
  float getMapY(){
    return mapY;
  }
  
  boolean isFinished(){
    return finished;
  }
  
  String toString(){
    return name;
  }
  
}
