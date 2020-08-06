import 'dart:io';

import 'package:image/image.dart';

main() {
  var image = decodeImage(File('map.png').readAsBytesSync());

  List<List<int>> map = [];
  for (int y = 0; y < image.height; y++) {
    map.add([]);
    for (int x = 0; x < image.width; x++) {
      map[y].add(convertToMapValue(
          x + 1, y + 1, image.getPixel(x, image.height - y - 1)));
    }
  }

  File('../lib/world/map.dart')
      .writeAsString('List<List<int>> rawMap = ' + map.toString() + ';');
}

int convertToMapValue(int x, int y, int value) {
  switch (value) {
    case 0xffffffff: // #FFFFFF
      return 0;
    case 0xff000000: // #000000
      return 1;
    case 0xff0000ff: // #FF0000
      return 2;
    case 0xffff00ff: // #FF00FF
      return 3;
    case 0xff00ff00: // #00FF00
      return 4;
    default:
      throw ("Unknown block with color " +
          value.toString() +
          " at " +
          x.toString() +
          ", " +
          y.toString());
  }
}
