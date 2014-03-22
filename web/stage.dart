
import 'dart:math';
import 'dart:html';
import 'triangle.dart';
import 'text_measuring_service.dart';


class Stage {
  
  int width;
  DivElement root;
  int height;
  int numTris;
  List <Triangle> tris;
  
  Stage(int numTris, selector){
    
    this.root = querySelector(selector);
    // this.root.style.width = DEFAULTWIDTH * numTris;
    var totalTris = numTris * numTris + 14;
    // per line 60
    this.tris = [];
    this.width = numTris * DEFAULTWIDTH;
    for (int i = 0; i < totalTris; i++){
      var tri = this.makeTri();
      this.tris.add(tri);
      this.root.append(tri.el);
    }
    this.update();
  }
  
  update (){
    var points = this.getPoints('ABCD');
    points.forEach((point){
      var x = point.x;
      var y = point.y;
      var idx = y * 60 + x + 1;
      this.tris[idx].el.style.backgroundColor = 'rgba(32,32,32,0.9)';  
      
      
    });
  }
  
  getPoints (text){
    
    var tms = new TextMeasuringService(text:text, width:900, height: 130);
    var points = tms.measure(15);
    return points;
    
  }
  
  makeTri(){
    return new Triangle();
  }
}