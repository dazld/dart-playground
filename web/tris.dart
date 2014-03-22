import 'dart:html';
import 'dart:math';



rangeRandom(int min, int max){
  var val = new Random().nextInt(max-min) + min;
  return val.toDouble();
}

osc(min, max, inc){
  double current = min - inc;
  int direction = 1;
  return (){
    if(current >= max){
      direction = -1;
    }
    
    if(current <= min){
      direction = 1;
    }
    
    return current = current + (inc * direction);
  }; 
}

class Line {
  double x;
  double y;
  double ax;
  double ay;
  Map options;
  Function oscX;
  Function oscY;
  Function oscAX;
  Function oscAY;
  
  Line(options){
    this.options = options;
    this.x = options['x'];
    this.y = options['y'];
    this.ax = options['ax'];
    this.ay = options['ay'];
    this.oscX = osc(this.x, this.ax, 1);
    this.oscY = osc(this.y, this.ay, 1);
    this.oscAX = osc(this.x, this.ax, -1);
    this.oscAY = osc(this.y, this.ay, -1);
  }
  
  update(){
     this.x = this.oscX();
     this.y = this.oscY();
     this.ax = this.oscAX();
     this.ay = this.oscAY();
  }
  
  draw(CanvasRenderingContext2D ctx){
    this.update();
    ctx.beginPath();
    ctx.moveTo(this.x, this.y);
    
    ctx.lineTo(this.ax, this.ay);
    ctx.closePath();
    ctx.stroke();
  }
  
}


class Stage {
  int width;
  int height;
  List<Line> lines;
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  
  Stage(width, height){
    this.width = width;
    this.height = height;
    this.canvas = new CanvasElement(width:width, height:height);
    this.canvas.setAttribute('width', this.width.toString());
    this.canvas.setAttribute('height', this.height.toString());
    this.context = this.canvas.getContext('2d');
    this.lines = [];
    var numLines = 10;
    
    while (numLines > 0){

      num startX = rangeRandom(0, this.width);
      num startY = rangeRandom(0, this.height);
      num endX = rangeRandom(0, this.height);
      num endY = rangeRandom(0, this.width);
    
      this.lines.add(new Line({
        'x': startX,
        'y': startY,
        'ax': endX,
        'ay': endY
      }));
      numLines--;
    }
    
    document.body.append(this.canvas);
  }
  
  drawLine(){
    this.context.fillStyle = 'rgba(255,255,255,0.05)';
    this.context.fillRect(0, 0, width, height);
    this.lines.forEach((line){
      line.draw(this.context);
    });
    
    
  } 
}


main(){
  
  Stage s = new Stage(512, 512);
  animate(num){
    
    s.drawLine();
    window.requestAnimationFrame(animate);
  };
  
  animate(0);
  
}

