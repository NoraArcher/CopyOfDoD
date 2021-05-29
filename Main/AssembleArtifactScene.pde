public class AssembleArtifactScene extends Scene {
  
  //UrnShard[] shards;
  //private float super.mapX, super.mapY; (from Scene)
  //private boolean super.isFinished;
  
  AssembleArtifactScene(){
    super.mapX = (width/2);
    super.mapY = 200;
    super.isFinished = false;
    //shards = new UrnShard[5];
    //shards[0] = new UrnShard("shard1.jpg");
  }
  
  void display(){
    fill(0,137,137);//blue
    rect(75, 125, width-150, height-250, 10);
    //for (UrnShard s : shards){
    //  s.display();
    //}
  }
  
  void keyHandler(int code){
  }
  
  void mouseHandler(int x, int y){
  }  
  
}
