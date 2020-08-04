import 'dart:io';
import 'package:image/image.dart';

int main() {
  var image = decodeImage(File('map.png').readAsBytesSync());
  List<List<int>> map = [];
  for (int y = 0; y < image.height; y++) {
    map.add([]);
    for (int x = 0; x < image.width; x++) {
      map[y].add(
          convertToMapValue(
              image.getPixel(x, image.height - 1 - y)
          )
      );
    }
  }
  new File('../lib/world/map.dart').writeAsString(
    'List<List<int>> rawMap = ' + map.toString() + ';'
  );
  return 0;
}

int convertToMapValue(int value) {
  switch (value) {
    case 0:
      return 0;
    case 4278190080:
      return 1;
    case 4278190335:
      return 2;
    case 4294902015:
      return 3;
    default:
      throw('Unknown block value $value');
  }
}
