import 'package:thoughts/physics/object.dart';
import 'package:thoughts/world/chunk.dart';
import 'package:thoughts/world/map.dart';
import 'package:thoughts/world/obstacle.dart';

import 'block.dart';

class World {
  static const CHUNKS_X = 10;
  static const CHUNKS_Y = 10;

  static World _instance;

  List<List<Chunk>> chunks = [];
  List<PhysicsObject> physicsObjects = [];

  World() {
    _instance = this;

    for (var y = 0; y < rawMap.length; y++) {
      for (var x = 0; x < rawMap[y].length; x++) {
        var chunkX = x ~/ Chunk.BLOCKS_PER_CHUNK;
        while (chunks.length <= chunkX) {
          chunks.add([]);
        }
        var chunkY = y ~/ Chunk.BLOCKS_PER_CHUNK;
        while (chunks[chunkX].length <= chunkY) {
          chunks[chunkX].add(Chunk(chunkX, chunkY));
        }
        var chunk = chunks[chunkX][chunkY];
        chunk.setGlobalBlock(x, y, _fromId(x, y, rawMap[y][x]));
      }
    }
  }

  static World get instance {
    return _instance;
  }

  Block _fromId(int x, int y, int id) {
    if (id == 1) {
      return Block(x, y);
    } else if (id == 2) {
      return Obstacle(x, y, false);
    } else if (id == 3) {
      return Obstacle(x, y, true);
    }
    return null;
  }

  Block getBlock(int x, int y) {
    var chunk = getChunk(x, y);
    if (chunk == null) {
      return null;
    }
    return chunk.getGlobalBlock(x, y);
  }

  Chunk getChunk(int x, int y) {
    if (x < 0 || y < 0) {
      return null;
    }

    var chunkX = x ~/ Chunk.BLOCKS_PER_CHUNK;
    var chunkY = y ~/ Chunk.BLOCKS_PER_CHUNK;

    if (chunks.length < chunkX && chunks[chunkX].length < chunkY) {
      return null;
    }
    return chunks[chunkX][chunkY];
  }

  update(double t) {
    physicsObjects.forEach((f) => f.update(t));
  }
}
