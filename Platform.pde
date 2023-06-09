class Platform{
  float w, h, x, y;
  String typeof;
  float halfWidth, halfHeight;
  PImage img;
  
  Platformer p;
  
  Platform(float _x, float _y, float _w, float _h, String _typeof, PImage _img){
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    typeof = _typeof;
    img = _img;

    halfWidth = w/2;
    halfHeight = h/2;
  }

  void display(){
    fill(0, 0, 0, 0);
    stroke (0, 0);
    rect(x, y, w, h);
    image(img, x, y);
    if (w < 100) {
      image(img, x, y);
    }
    else {
      float tempx = w;
      for(int i = 0; tempx >= 100; i++) {
        image(img, x + (100 * i), y);
        tempx -= 100;
      }
    }
    if (h < 100) {
      image(img, x, y);
    }
    else {
      float tempy = h;
      for(int i = 0; tempy >= 100; i++) {
        image(img, x, y + (100 * i));
        tempy -= 100;
      }
    }
  }
}
    
