public abstract class Scene {
  
  private float mapX, mapY;
  private boolean isFinished;
  
  abstract void display();//to be called in draw
  
  abstract void gameplay();//to be called in mousePressed?
  
  float getMapX(){
    return mapX;
  }
  
  float getMapY(){
    return mapY;
  }
  
  boolean isFinished(){
    return isFinished;
  }
  
}
