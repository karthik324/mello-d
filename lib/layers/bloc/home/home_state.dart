abstract class MusicState {}

class InitialMusicState extends MusicState {}

class NoPermissionState extends MusicState {}

class GainedPermissionState extends MusicState {}

class LoadMusicState extends MusicState {}

class GainedMusicState extends MusicState {}

class PlayMusicState extends MusicState {
  final String duration;
  final String position;
  final bool isPlaying;
  final double value;
  final double maxDuration;

  PlayMusicState({
    required this.duration,
    required this.position,
    required this.isPlaying,
    required this.value,
    required this.maxDuration,
  });
}

class PauseMusicState extends MusicState {
  final String duration;
  final String position;

  PauseMusicState({
    required this.duration,
    required this.position,
  });
}
