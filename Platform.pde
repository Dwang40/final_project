class Platform {
  float w,h,x,y;
  String typeOf;
  float halfWidth, halfHeight;
  
  Platform(float _x, float _y, float _w, float _h, String _typeOf) {
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    typeOf = _typeOf;
    
    halfWidth = w/2;
    halfHeight = h/2;
  }
  
  void display() {
    fill(0, 0, 255);
    rect(x, y, w, h);
  }
}
