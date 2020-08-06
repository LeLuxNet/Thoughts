import 'package:thoughts/graphic/renderable.dart';
import 'package:thoughts/graphic/void.dart';
import 'package:thoughts/physics/object.dart';
import 'package:thoughts/player.dart';
import 'package:thoughts/world/block/block.dart';
import 'package:thoughts/world/location.dart';

class Checkpoint extends Block {
  Checkpoint(x, y) : super(x, y) {
    solid = false;
  }

  @override
  void collide(PhysicsObject object) {
    if (object is Player) {
      object.checkpointLoc = Location(x.toDouble(), y.toDouble());
      object.checkpointSide = object.gravitySide;
    }
  }

  Renderable draw(double size) {
    return Void.VOID;
  }
}
