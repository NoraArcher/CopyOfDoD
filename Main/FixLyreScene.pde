public class FixLyreScene extends Scene {
    private PImage emptyLyre;

    FixLyreScene() {
        super(200, 200, "Fix Lyre");
        emptyLyre = loadImage("emptyLyre.png");
        println("Constructor");
    }

    void display() {
        println("display lyre scene");

        // Background and border
        background(75, 175, 184); // darker cyan-ish
        stroke(255, 215, 0); strokeWeight(8);
        fill(160, 186, 147);
        rect(75, 125, width-150, height-250, 10);
        noStroke();

        // Empty lyre
        image(emptyLyre, width/2 - emptyLyre.width/2, height/2 - emptyLyre.height/2);
    }

    void keyHandler(int code) {
        println("key handler lyre scene " + code);
    }

    void mouseHandler() {
        println("mouse handler lyre scene " + mouseX + " " + mouseY);
    }
}
