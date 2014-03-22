
import 'dart:math';
import 'dart:html';
import 'triangle.dart';



class Stage {
  
  int width;
  DivElement root;
  int height;
  int numTris;
  List <Triangle> tris;
  
  Stage(int numTris, selector){
    
    this.root = querySelector(selector);
    // this.root.style.width = DEFAULTWIDTH * numTris;
    var totalTris = numTris * numTris;
    this.width = numTris * DEFAULTWIDTH;
    for (int i = 0; i < totalTris; i++){
      var tri = this.makeTri();
      this.tris.add(tri);
      this.root.append(tri.el);
    } 
  }
  
  makeTri(){
    return new Triangle();
  }
}