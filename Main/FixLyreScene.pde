public class FixLyreScene extends Scene {
    FixLyreScene() {
        println("Constructor");
    }

    void display() {
        println("display lyre scene");
    }

    void keyHandler(int code) {
        println("key handler lyre scene " + code);
    }

    void mouseHandler() {
        println("mouse handler lyre scene " + mouseX + " " + mouseY);
    }
}
