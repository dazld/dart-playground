import 'dart:html';
import 'dart:math';

import 'utils.dart' as utils;

const int DEFAULTWIDTH = 30;

class Triangle {
  
  int _width = DEFAULTWIDTH;
  int _height = 30;
  DivElement el;
  
  Point center;
  
  Triangle(){
    
    this.el = new DivElement();
    this.el.className = 'tri';
  }
  
}