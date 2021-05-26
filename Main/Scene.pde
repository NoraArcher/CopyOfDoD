public abstract class Scene {
  
  private int mapX, mapY;
  private boolean isFinished;
  
  abstract void display();//to be called in draw
  
  abstract void gameplay();//to be called in mousePressed?
  
}
