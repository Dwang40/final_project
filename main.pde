//Global Variables
Platformer p;
Platform [] platforms;

PImage [] spriteImages;
int frames;

boolean left, right, up, down, space;
FrameObject camera, gameWorld;
ImageObject backImage;
PImage forest, A, B, S, WIN;

void setup() {
  size(1400, 800);

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;

  forest = loadImage("data/background.jpg");
  backImage = new ImageObject(0, 0, 1400, 800, forest);
  gameWorld = new FrameObject(0, 0, backImage.w * 2, backImage.h);
  camera = new FrameObject(0, 0, width, height);

  camera.x = (gameWorld.x + gameWorld.w/2) - camera.w/2;
  camera.y = (gameWorld.y + gameWorld.h/2) - camera.h/2;


  //player values
  p = new Platformer();
  frames = 48;
  spriteImages = new PImage[frames];
  for (int i = 0; i < frames; i++) {
    spriteImages[i] = loadImage("data/player" + nf(i + 1, 4) + ".png");
  }
  
  A = loadImage("data/ADirt.png");
  B = loadImage("data/BDirt.png");
  S = loadImage("data/Spikes.png");
  WIN = loadImage("data/win.png");
  platforms = new Platform[15];
  
  platforms[0] = new Platform (0, gameWorld.h-100, gameWorld.w, 100, "safe", A);
  platforms[1] = new Platform (300, 600, 200, 100, "safe", A);
  platforms[2] = new Platform (300, 700, 200, 100, "safe", B);
  platforms[3] = new Platform (500, 600, 800, 100, "death", S);
  platforms[4] = new Platform (1300, 200, 100, 700, "safe", B);
  platforms[5] = new Platform (700, 500, 200, 100, "safe", A);
  platforms[6] = new Platform (1300, 200, 100, 100, "safe", A);
  platforms[7] = new Platform (1100, 300, 200, 100, "safe", A);
  platforms[8] = new Platform (1400, 600, 1400, 100, "death", S);
  platforms[9] = new Platform (2700, 200, 100, 700, "safe", B);
  platforms[10] = new Platform (2700, 200, 100, 100, "win", WIN);
  platforms[11] = new Platform (1400, 500, 200, 100, "safe", A);
  platforms[12] = new Platform (1800, 300, 100, 100, "safe", A);
  platforms[13] = new Platform (2100, 300, 100, 100, "safe", A);
  platforms[14] = new Platform (2500, 200, 100, 100, "safe", A);
}

void draw() {
  background(255);
  p.update();
  for (int i = 0; i < platforms.length; ++i) {
    p.collisionSide = rectangleCollisions(p, platforms[i]);
    if (p.collisionSide != "none" && platforms[i].typeof == "death") {
      if (p.x >= backImage.w) {
        p.check1();
      } else {
        if (p.x >= backImage.w * 2) {
          p.check2();
        }
        else p.reset();
      }
    }
    if (p.collisionSide != "none" && platforms[i].typeof == "win") {
      println("YOU WIN!");
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
}

String rectangleCollisions(Platformer r1, Platform r2) {
  //r1 is the player
  //r2 is the platform rectangle
  //function returns the String collisionSide

  float dx = (r1.x + r1.w/2) - (r2.x + r2.w/2);
  float dy = (r1.y + r1.h/2) - (r2.y + r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    if (abs(dy) < combinedHalfHeights) {
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      if (overlapX >= overlapY) {
        if (dy > 0) {
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
