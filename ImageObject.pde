class ImageObject{
  float w, h, x, y;
  PImage img;
  float halfWidth, halfHeight;

  ImageObject(float _x, float _y, float _w, float _h, PImage _img){
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    img = _img;

    halfWidth = w/2;
    halfHeight = h/2;
  }

  void display(){
    fill(0, 0, 255, 128);
    rect(x, y, w, h);
    image(img, x,y);
    image(img, x + w,y);
  }
}
