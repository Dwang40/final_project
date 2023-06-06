//Global Variables
Platformer p;
Platform [] platforms;

PImage [] spriteImages;
int frames;

boolean left, right, up, down, space;
FrameObject camera, gameWorld;
ImageObject backImage;
PImage forest;

void setup() {
  size(1435, 800);

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;

  forest = loadImage("data/background.jpg");
  backImage = new ImageObject(0, 0, 1435, 800, forest);
  gameWorld = new FrameObject(0, 0, backImage.w * 2, backImage.h);
  camera = new FrameObject(0, 0, width, height);

  camera.x = (gameWorld.x + gameWorld.w/2) - camera.w/2;
  camera.y = (gameWorld.y + gameWorld.h/2) - camera.h/2;


  //player values
  p = new Platformer();
  frames = 48;
  spriteImages = new PImage[frames];
  for (int i = 0; i < frames; i++) {
    spriteImages[i] = loadImage("data/player" + nf(i+1, 4) + ".png");
  }

  platforms = new Platform[7];
  platforms[0] = new Platform (300, 460, 200, 25, "safe");
  platforms[1] = new Platform (0, 300, 200, 25, "safe");
  platforms[2] = new Platform (600, 300, 200, 25, "safe");
  platforms[3] = new Platform (300, 140, 200, 25, "safe");
  platforms[4] = new Platform (824, 460, 200, 25, "safe");
  platforms[5] = new Platform (824, 140, 200, 25, "safe");
  platforms[6] = new Platform (0, gameWorld.h-20, gameWorld.w, 25, "death");
}

void draw() {
  background(255);
  p.update();
  for (int i = 0; i < platforms.length; ++i) {
    p.collisionSide = rectangleCollisions(p, platforms[i]);
    if (p.collisionSide != "none" && platforms[i].typeof == "death") {
      p.c = color(255,0,0);
    }
    p.checkPlatforms();
  }
  //Move the camera
  camera.x = floor(p.x + (p.halfWidth) - (camera.w / 2));
  camera.y = floor(p.y + (p.halfHeight) - (camera.h / 2));

  //Keep the camera inside the gameWorld boundaries
  if (camera.x < gameWorld.x) {
    camera.x = gameWorld.x;
  }
  if (camera.y < gameWorld.y) {
    camera.y = gameWorld.y;
  }
  if (camera.x + camera.w > gameWorld.x + gameWorld.w) {
    camera.x = gameWorld.x + gameWorld.w - camera.w;
  }
  if (camera.y + camera.h > gameWorld.h) {
    camera.y = gameWorld.h - camera.h;
  }

  pushMatrix();
  translate(-camera.x, -camera.y);

  backImage.display();
  p.display();
  for (int i = 0; i < platforms.length; ++i) {
    platforms[i].display();
  }

  popMatrix();
  displayPositionData();
}

String rectangleCollisions(Platformer r1, Platform r2) {
  ////r1 is the player
  ////r2 is the platform rectangle
  ////function returns the String collisionSide

  //allow unicorn to pass through platforms.
  //Disable if you want unicorn to bounce off bottom of platforms

  if (r1.vy < 0) { 
    return "none";
  }

  float dx = (r1.x + r1.w/2) - (r2.x + r2.w/2);
  float dy = (r1.y + r1.h/2) - (r2.y + r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      //determine the overlap on each axis
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      ////the collision is on the axis with the
      ////SMALLEST overlap
      if (overlapX >= overlapY) {
        if (dy > 0) {
          ////move the rectangle back to eliminate overlap
          ////before calling its display to prevent
          ////drawing object inside each other
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
      //collision failed on the y axis
      return "none";
    }
  } else {
    //collision failed on the x axis
    return "none";
  }
}

void displayPositionData() {
  fill(0);
  //String s = "\nvx: "+u.vx+"  vy: ";
  //text(s, 50, 50);
}

void keyPressed() {
  switch (keyCode) {
  case 37://left
    left = true;
    break;
  case 39://right
    right = true;
    break;
  case 38://up
    up = true;
    break;
  case 40://down
    down = true;
    break;
  case 32: //space
    space = true;
    break;
  }
}
void keyReleased() {
  switch (keyCode) {
  case 37://left
    left = false;
    break;
  case 39://right
    right = false;
    break;
  case 38://up
    up = false;
    break;
  case 40://down
    down = false;
    break;
  case 32: //space
    space = false;
    break;
  }
}
