import 'package:thoughts/world/block/block.dart';
import 'package:thoughts/world/block/obstacle.dart';

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
        blocks[localX].add(null);
      }
    }
  }

  Block getLocalBlock(int x, int y) {
    return blocks[x][y];
  }

  Block getGlobalBlock(int x, int y) {
    return blocks[x - this.x * BLOCKS_PER_CHUNK][y - this.y * BLOCKS_PER_CHUNK];
  }

  void setGlobalBlock(int x, int y, Block block) {
    blocks[x - this.x * BLOCKS_PER_CHUNK][y - this.y * BLOCKS_PER_CHUNK] =
        block;
  }
}
