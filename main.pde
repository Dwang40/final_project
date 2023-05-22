//Global Variables
Platformer p;
Platform pl;

boolean left, right, up, down, space;

void setup() {
  size(800, 600);
  
  left = false;
  right = false;
  up = false;
  down = false;
  space = false;
  
  //Platformer Values
  p = new Platformer();
  //Platform Values
  pl = new Platform(300, 400, 200, 25, "safe");
}

void draw() {
  background (255, 255, 255);
  p.update();
  p.collisionSide = rectangleCollisions(p, pl);
  p.display();
  pl.display();
  
  displayPositionData();
}

String rectangleCollisions(Platformer r1, Platform r2) {
  //r1 = player
  //r2 = platform
  //returns String collisionSide
  
  //allow player to pass through platforms
  //disable if you want player to bounce off the bottom of platform
  if (r1.vy < 0) {
    return "none";
  }
  
  float dx = (r1.x + r1.w/2) - (r2.x + r2.w/2);
  float dy = (r1.y + r1.h/2) - (r2.y + r2.h/2);
  
  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;
  
  if (abs(dx) < combinedHalfWidths) {
    //collision happened on the x axis
    //check y axis afterwards
    if (abs(dy) < combinedHalfHeights) {
      //collision detected
      //determine the overlap on each axis
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      //the collision is on the axis with the smallest overlap
      if (overlapX >= overlapY) {
        if (dy > 0) {
          //move rect back to fix overlap
          //before calling its display to prevent
          //drawing object inside each other
          r1.y += overlapY;
          return "top";
        } else {
          r1.y -= overlapY;
          return "bottom";
        }
      } else {
        if (dx > 0) {
          r1.x += overlapX;
          return "left";
        } else {
          r1.x -= overlapX;
          return "right";
        }
      }
    } else {
      //collision has failed on the y axis
      return "none";
    }
  } else {
    //collision has failed on the x axis
    return "none";
  }
}
  
//for testing
void displayPositionData() {
  fill(0);
  float dx = (p.x + p.w/2) - (pl.x + pl.w/2);
  float dy = (p.y + p.h/2) - (pl.y + pl.h/2);
  
  float combinedHalfWidths = p.halfWidth + pl.halfWidth;
  float combinedHalfHeight = p.halfHeight + pl.halfHeight;
  String s = "dx:" + dx + "  dy:" + dy + "\n" +
    "chw:" + combinedHalfWidths + "  chh:" + combinedHalfHeight +
    "\nvx: " + p.vx + "  vy: " + p.vy +
    "\ncollisionSide: " + p.collisionSide;
  text(s, 50, 50);
}

void keyPressed() {
  switch (keyCode) {
  case 37: //left
    left = true;
    break;
  case 39: // right
    right = true;
    break;
  case 38: //up
    up = true;
    break;
  case 40: // down
    down = true;
    break;
  case 32: //space
    space = true;
    break;
  }
}

void keyReleased() {
  switch (keyCode) {
  case 37: //left
    left = false;
    break;
  case 39: // right
    right = false;
    break;
  case 38: //up
    up = false;
    break;
  case 40: // down
    down = false;
    break;
  case 32: //space
    space = false;
    break;
  }
}
