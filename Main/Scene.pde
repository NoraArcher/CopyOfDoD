public abstract class Scene {
  
  private float mapX, mapY;
  private boolean finished;
  //private int endCount;
  
  abstract void display();//to be called in draw
  
  abstract void keyHandler(int code);
  
  abstract void mouseHandler(int x, int y);
  
  float getMapX(){
    return mapX;
  }
  
  float getMapY(){
    return mapY;
  }
  
  boolean isFinished(){
    return finished;
  }
  
}
