public abstract class Scene {
  
  private float mapX, mapY;
  private boolean finished;
  //private int endCount;//for ending 'animations', see AAScene for an example
  private String name;
  
  abstract void display();//to be called in draw
  
  abstract void keyHandler(int code);
  
  abstract void mouseHandler();
  
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
