import 'package:thoughts/world/block.dart';

class Chunk {
  static const BLOCKS_PER_CHUNK = 25;

  int x;
  int y;

  List<List<Block>> blocks = [];

  Chunk(this.x, this.y) {
    for (var localX = 0; localX < BLOCKS_PER_CHUNK; localX++) {
      blocks.add([]);
      var globalX = this.x * BLOCKS_PER_CHUNK + localX;
      for (var localY = 0; localY < BLOCKS_PER_CHUNK; localY++) {
        var globalY = this.y * BLOCKS_PER_CHUNK + localY;
        blocks[localX].add(_genBlock(globalX, globalY));
      }
    }
  }

  Block _genBlock(int x, int y) {
    if (y % 10 == 0 || (y % 10 == 1 && x % 2 == 0)) {
      return Block(x, y);
    }
    return null;
  }

  Block getLocalBlock(int x, int y) {
    return blocks[x][y];
  }

  Block getGlobalBlock(int x, int y) {
    x -= this.x * BLOCKS_PER_CHUNK;
    y -= this.y * BLOCKS_PER_CHUNK;
    return getLocalBlock(x, y);
  }
}
