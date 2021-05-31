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
  }

  void display() {
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
    for (LyreWire w : wires) {
      if (w.selected()) {
        strokeWeight(4);
        stroke(w.getColor());
        line(w.getXInitial(), w.getYInitial(), mouseX, mouseY);
        noStroke();
        w.setCoords(mouseX, mouseY);

        w.settle();
        break;
      }
    }
  }

  void mousePressedHandler() {
    println("mouse handler lyre scene " + mouseX + " " + mouseY);
    for (LyreWire w : wires) {
      if (dist(w.getXInitial(), w.getYInitial(), mouseX, mouseY) < 10) {
        w.setSelected(true);
      }
    }
  }

  void mouseReleasedHandler() {
    for (LyreWire w : wires) {
      w.setSelected(false);
    }
  }
}

private class LyreWire extends DraggableObject {
  private float xInitial, yInitial;
  private color c;
  private boolean isSelected;

  // COORDINATES
  final float[] STARTX = {399, 395, 393, 387};
  final float[] STARTY = {311, 373, 438, 505};
  final float[] ENDX = {567, 592, 584, 550};
  final float[] ENDY = {314, 369, 453, 515};

  LyreWire(int start, int end, color c) {
    setCoords(STARTX[start], STARTY[start], ENDX[end], ENDY[end]);
    this.c = c;
    this.xInitial = getX();
    this.yInitial = getY();
    this.isSelected = false;
  }

  float getXInitial() {
    return xInitial;
  }

  float getYInitial() {
    return yInitial;
  }

  color getColor() {
    return c;
  }

  boolean selected() {
    return isSelected;
  }

  void setSelected(boolean selected) {
    isSelected = selected;
  }

  void display() {
    fill(getColor());
    ellipse(getXInitial(), getYInitial(), 20, 20);
    ellipse(getXFinal(), getYFinal(), 20, 20);

    if (isSettled()) {
      strokeWeight(4);
      stroke(getColor());
      line(getXInitial(), getYInitial(), getXFinal(), getYFinal());
      noStroke();
    }
  }

  void settle() {
    if (dist(getX(), getY(), getXFinal(), getYFinal()) < 10) {
      setSelected(false);
      setCoords(getXFinal(), getYFinal());
      setSettled(true);
    }
  }
}
