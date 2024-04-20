abstract class SpeedState {}

class SpeedInitial extends SpeedState {}

class CorrectSpeed extends SpeedState {
  final double speed;
  CorrectSpeed(this.speed);
}

class OverSpeed extends SpeedState {
  final double speed;
  OverSpeed(this.speed);
}
