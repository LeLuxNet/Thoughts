import 'package:thoughts/physics/object.dart';
import 'package:thoughts/world/chunk.dart';

import 'block.dart';

class World {
  static const CHUNKS_X = 10;
  static const CHUNKS_Y = 10;

  static World _instance;

  List<List<Chunk>> chunks = [];
  List<PhysicsObject> physicsObjects = [];

  World() {
    _instance = this;

    for (var x = 0; x < CHUNKS_X; x++) {
      chunks.add([]);
      for (var y = 0; y < CHUNKS_Y; y++) {
        chunks[x].add(Chunk(x, y));
      }
    }
  }

  static World get instance {
    return _instance;
  }

  Block getBlock(int x, int y) {
    if (x < 0 || y < 0) {
      return null;
    }
    return getChunk(x, y).getGlobalBlock(x, y);
  }

  Chunk getChunk(int x, int y) {
    return chunks[x ~/ Chunk.BLOCKS_PER_CHUNK][y ~/ Chunk.BLOCKS_PER_CHUNK];
  }

  update(double t) {
    physicsObjects.forEach((f) => f.update(t));
  }
}
