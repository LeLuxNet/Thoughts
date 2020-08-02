import 'package:thoughts/physics/object.dart';
import 'package:thoughts/world/location.dart';

class Player extends PhysicsObject {

  int jumped = 0;

  int hearts = 3;

  Player(Location loc, GravitySide gravitySide) : super(2, 1, loc, gravitySide);

  @override
  void update(double t) {
    super.update(t);
    if (grounded()) {
      jumped = 0;
    }
  }
}
