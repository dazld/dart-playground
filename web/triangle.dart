import 'dart:html';
import 'dart:math';

import 'utils.dart' as utils;

const int DEFAULTWIDTH = 10;

class Triangle {
  
  int _width = DEFAULTWIDTH;
  int _height = 10;
  DivElement el;
  
  Point center;
  
  Triangle(){
    
    this.el = new DivElement();
    this.el.className = 'tri';
    
//    this.setupEvents();
  }
  
  
  setupEvents() {
    this.el.addEventListener('click', (e) {
       this.el.classes.add('broken');
    });
  }
  
}