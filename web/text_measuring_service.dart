import 'dart:html';


class TextMeasuringService {
  String text;

  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;

  int width;
  int height;

  TextMeasuringService({this.text, this.width, this.height}) {

    _canvas = new CanvasElement(width: width, height: height);
    _ctx = _canvas.getContext('2d');

    _canvas.setAttribute('width', width.toString());
    _canvas.setAttribute('height', height.toString());

    var metrics = _ctx.measureText(text);

    _ctx.font = '100px Monaco';
    _ctx.fillText(text, 0, 100, width);
  }

  List<Point> measure(int boxSize) {
    List<Point> result = [];
    
    List<int> allData = _ctx.getImageData(0, 0, width, height).data;
    print(allData.length);

    for (int i = 0; i * boxSize < width; i++) {
      for (int j = 0; j * boxSize < height; j++) {
        print('GO: $i, $j');
        int blackPixels = 0;
        int whitePixels = 0;

        for (var ix = 0; ix < boxSize; ix++) {
          var itemIndex = 4 * j * width + i * boxSize * 4 + ix * 4 + 3;
//          var itemIndex = i * j * 4; 
//          print(itemIndex);
          var item = allData[itemIndex];
          
          if (item > 0) {
            blackPixels++;
          } else {
            whitePixels++;
          }
        }

        if (blackPixels > 0) {
          result.add(new Point(i, j));
        }

      }
    }

    return result;
  }
}
