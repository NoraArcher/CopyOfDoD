import java.util.*;
public class FixLyreScene extends Scene {
  private PImage emptyLyre;
  private LyreWire[] wires;

  // COLORS
  final color[] COLORS = {
    color(255, 0, 0), // red
    color(0, 0, 255), // blue
    color(255, 0, 255), // magenta
    color(255, 255, 0) // yellow
  };

  FixLyreScene() {
    super(200, 200, "Fix Lyre");
    emptyLyre = loadImage("emptyLyre.png");
    wires = new LyreWire[4];

    List<Integer> starts = Arrays.asList(new Integer[] {0, 1, 2, 3});
    List<Integer> ends = Arrays.asList(new Integer[] {0, 1, 2, 3});
    Collections.shuffle(starts);
    Collections.shuffle(ends);

    for (int i = 0; i < wires.length; i++) {
      wires[i] = new LyreWire(starts.get(i), ends.get(i), COLORS[i]);
    }

    println("Constructor");
  }

  void display() {
    println("display lyre scene");

    // Background and border
    background(75, 175, 184); // darker cyan-ish
    stroke(255, 215, 0); strokeWeight(8); // gold
    fill(160, 186, 147); // pale green-ish
    rect(75, 125, width-150, height-250, 10);
    noStroke();

    // Empty lyre
    image(emptyLyre, width/2 - emptyLyre.width/2, height/2 - emptyLyre.height/2);

    // Wires
    for (LyreWire w : wires) {
      w.display();
    }
  }

  void keyHandler(int code) {
    println("key handler lyre scene " + code);
  }

  void mouseHandler() {
    println("mouse handler lyre scene " + mouseX + " " + mouseY);
  }
}

private class LyreWire extends DraggableObject {
  private int xInitial, yInitial;
  private color c;

  // COORDINATES
  final int[] STARTX = {399, 398, 393, 387};
  final int[] STARTY = {311, 350, 438, 505};
  final int[] ENDX = {567, 592, 584, 550};
  final int[] ENDY = {314, 369, 453, 515};

  LyreWire(int start, int end, color c) {
    setCoords(STARTX[start], STARTY[start], ENDX[end], ENDY[end]);
    this.c = c;
    this.xInitial = getX();
    this.yInitial = getY();
  }

  int getXInitial() {
    return xInitial;
  }

  int getYInitial() {
    return yInitial;
  }

  color getColor() {
    return c;
  }

  void display() {
    
  }
}
