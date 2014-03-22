
import 'dart:math';
import 'dart:html';
import 'dart:async';
import 'triangle.dart';
import 'text_measuring_service.dart';


class Stage {
  
  int width;
  DivElement root;
  int height;
  int numTris;
  List <Triangle> tris;
  Timer refresh;
  
  Stage(selector){
    
    this.root = querySelector(selector);
    // this.root.style.width = DEFAULTWIDTH * numTris;
    var totalTris = 120 * 40;
    // per line 120
    this.tris = [];
    
    for (int i = 0; i < totalTris; i++){
      var tri = this.makeTri();
      this.tris.add(tri);
      this.root.append(tri.el);
    }
    
    var duration = new Duration(seconds:1);
    
    this.refresh = new Timer.periodic(duration, this.update);
    
    //this.update();
    
  }
  
  update ([delta = null]){
    var now = new DateTime.now();
    var time = now.toString().split(' ')[1].split('.')[0];
    
    print(time);
    
    this.root.querySelectorAll('.active').classes.remove('active');
    
    var points = this.getPoints(time);
    points.forEach((point){
      var x = point.x;
      var y = point.y;
      var idx = y * 120 + x + 25;
      this.tris[idx].el.classes.add('active');
    });
  }
  
  getPoints (text){
    
    var tms = new TextMeasuringService(text:text, width:900, height: 300);
    var points = tms.measure(5);
    return points;
    
  }
  
  makeTri(){
    return new Triangle();
  }
}