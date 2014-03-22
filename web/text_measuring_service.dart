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

    for (int i = 0; i * boxSize < width; i++) {
      for (int j = 0; j * boxSize < height; j++) {
        int blackPixels = 0;
        int whitePixels = 0;

        for (var ix = 0; ix < boxSize; ix++) {
          for (var jx = 0; jx < boxSize; jx++) {
            var itemIndex = 4 * (j * boxSize + jx) * width + i * boxSize * 4 + 4 * ix + 3;
            var item = allData[itemIndex > allData.length ? allData.length - 1 : itemIndex];

            if (item > 0) {
              blackPixels++;
            } else {
              whitePixels++;
            }
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
