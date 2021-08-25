import processing.video.*;
import java.awt.Robot;
import java.awt.event.MouseEvent;

Capture c;

color track;
float threshold;

ArrayList<Blob> blobs;

float x;
float y;

Robot r;

boolean move;

void setup() {
  size(680, 480);
  c = new Capture(this, width, height);
  c.start();
  track = color(0, 0, 255);
  threshold = 150;
  blobs = new ArrayList<Blob>();
  move = false;
  try{
    r = new Robot();
  }catch(Exception ex){
   print(ex); 
  }
}

void captureEvent(Capture c) {
  c.read();
}

void draw() {
  image(c, 0, 0);
  loadPixels();
  stroke(0);
   strokeWeight(3);
   blobs.clear();
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {

      int loc = x+y*width;

      float r1 = red(pixels[loc]);
      float g1 = green(pixels[loc]);
      float b1 = blue(pixels[loc]);

      float r2 = red(track);
      float g2 = green(track);
      float b2 = blue(track);

      float d = dist(r1, g1, b1, r2, g2, b2);

      if (d<threshold) {

        boolean found = false;
        for (Blob blob : blobs) {
          if (blob.isNear(x, y)) {
            blob.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob blob = new Blob(x, y);
          blobs.add(blob);
        }
      }
    }
  }

  for (Blob blob : blobs) {
    if (blob.getSize()>100) {
      fill(255, 100);
      blob.show();
      fill(200,0,200);
      PVector center = blob.getCenter();
      x = center.x;
      y = center.y;
      circle(center.x,center.y,30);
    }
  }
  
  if(move){
   try{
    r.mouseMove(displayWidth-int(x)*2,int(y)*2); 
    if(blobs.size()>1){
     r.mousePress(MouseEvent.BUTTON1_DOWN_MASK);
     r.mouseRelease(MouseEvent.BUTTON1_DOWN_MASK);
    }
   }catch(Exception ex){
    print(ex); 
   }
  }
}

void keyPressed(){
  move=!move;
}
