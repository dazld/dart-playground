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

