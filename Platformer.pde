class Platformer {
  
  float w, h, x, y, vx, vy,
    accelerationX, accelerationY,
    speedLimit;
    
  float friction, bounce, gravity;
  
  boolean isOnGround;
  float jumpForce;
  
  float halfWidth, halfHeight;
  String collisionSide;
  
   Platformer() {
    w = 100; //was 140. shrunk to fit
    h = 65; // was 95. shrunk to fit
    x = 400;
    y = 150;
    vx = 0;
    vy = 0;
    accelerationX = 0;
    accelerationY = 0;
    speedLimit = 10;
    isOnGround = false;
    jumpForce = -17;
    
    //world values
    friction = 0.96;
    bounce = -0.7;
    gravity = 0.3;
    
    halfWidth = w/2;
    halfHeight = h/2;
    
    collisionSide = "";
  }
  
  void update() {
    if (left && !right) {
      accelerationX = -0.2;
      friction = 1;
    }
    if (right && !left) {
      accelerationX = 0.2;
      friction = 1;
    }
    if (!left && !right) {
      accelerationX = 0;
    }
    
    if (up && !down && isOnGround) {
      vy = jumpForce;
      isOnGround = false;
      // gravity = 0;
      friction = 1;
    }
    
    /*
    if (up && !down) {
      accelerationY = -0.2;
      gravity = 0;
      friction = 1;
    }
    if (down && !up) {
      accelerationY = 0.2;
      friction = 1;
    }
    if (!up && !down) {
      accelerationY = 0;
    }
    */
    
    //removing impulse reintroduces friction
    if (!up && !down && !left && !right) {
      friction = 0.96;
      //gravity = 0.8; 
    }
    
    vx += accelerationX;
    vy += accelerationY;
    
    //accounting for friction, 1 = no friction
    vx *= friction;
    vy *= friction;
    
    //apply gravity
    vy += gravity;
    
    //correct for max speeds
    if (vx > speedLimit) {
      vx = speedLimit;
    }
    if (vx < -speedLimit) {
      vx = -speedLimit;
    }
    //gravity does it's thing
    if (vy > 3 * speedLimit) {
      vy = 3 * speedLimit;
    }
    //isnt used when jumping
    /*
    if (vy < -speedLimit) {
      vy = -speedLimit;
    }
    */
    
    //moves player
    x += vx;
    y += vy;
    
    //correct min speeds 
    if (abs(vx) < 0.2) {
      vx = 0;
    }
    
    if (abs(vy) < 0.3) {
      vy = 0;
    }
    
    checkBoundaries();
    checkPlatforms();
  }
  
  void checkBoundaries() {
    //left
    if (x < 0){
      vx *= bounce;
      x = 0;
    }
    //right
    if (x + w > width){
      vx *= bounce;
      x = width - w;
    }
    //top/up
    if (y < 0){
      vy *= bounce;
      y = 0;
    }
    //bottom/down
    if (y + h > height){
      if (vy < 1) {
        isOnGround = true;
        y = 0;
      } else {
      //reduced for floor bouncing
      vy *= bounce/100;
    }
    y = height - h; 
    }
  }
  
  void checkPlatforms() {
    //update for platform collisions
    if(collisionSide == "bottom" && vy >= 0) {
      if (vy < 1) {
        isOnGround = true;
        vy = 0;
        println("top");
      } else {
        //reduce bounce for floor b
        vy *= bounce/100;
      }
    } else if (collisionSide == "top" && vy <= 0) {
      vy = 0;
    } else if (collisionSide == "right" && vx >= 0) {
      vx = 0;
    } else if (collisionSide == "left" && vx <= 0) {
      vx = 0;
    }
    if (collisionSide != "bottom" && vy > 0) {
      isOnGround = false;
    }
  }
  
  void display () {
    fill(0, 255, 0, 128);
    rect(x, y, w, h);
  }
}
