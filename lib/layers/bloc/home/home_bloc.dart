import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mello_d/layers/bloc/home/home_event.dart';
import 'package:mello_d/layers/bloc/home/home_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicBloc extends Bloc<LoadMusicEvent, MusicState> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  bool hasPermission = false;
  bool isPlaying = false;
  String duration = '';
  String position = '';
  var maxDuration = 0.0, value = 0.0;
  String currentMusic = '';

  MusicBloc() : super(InitialMusicState()) {
    on<NoPermissionEvent>(
      (event, emit) => emit(
        NoPermissionState(),
      ),
    );

    on<GainedPermissionEvent>(
      (event, emit) => emit(
        GainedPermissionState(),
      ),
    );

    on<InitMusicEvent>(
      (event, emit) => emit(
        InitialMusicState(),
      ),
    );

    on<SetMusicEvent>(
      (event, emit) => emit(
        GainedMusicState(),
      ),
    );

    on<PlayMusicEvent>(
      (event, emit) => emit(
        PlayMusicState(
          duration: duration,
          position: position,
          isPlaying: isPlaying,
          value: value,
          maxDuration: maxDuration,
        ),
      ),
    );

    on<PauseMusicEvent>(
      (event, emit) => emit(
        PauseMusicState(
          duration: duration,
          position: position,
        ),
      ),
    );

    checkAndRequestPermissions();
  }

  void playMusic(String uri) {
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            uri,
          ),
        ),
      );
      audioPlayer.play();
      isPlaying = true;
      updatePosition();
      currentMusic = uri;
      add(PlayMusicEvent());
    } catch (e) {
      print(e.toString());
    }
  }

  void pauseMusic(String uri) {
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            uri,
          ),
        ),
      );
      audioPlayer.pause();
      isPlaying = false;
      add(PauseMusicEvent());
    } catch (e) {
      print(e.toString());
    }
  }

  void updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration = d.toString().split(".")[0];
      maxDuration = d?.inSeconds.toDouble() ?? 0;
      add(PlayMusicEvent());
    });
    audioPlayer.positionStream.listen((p) {
      position = p.toString().split(".")[0];
      value = p.inSeconds.toDouble();
      add(PlayMusicEvent());
    });
  }

  void changeDurationToSec(int sec) {
    var duration = Duration(seconds: sec);
    audioPlayer.seek(duration);
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    // _hasPermission ? setState(() {}) : null;
    if (hasPermission) {
      add(GainedPermissionEvent());
    } else {
      add(NoPermissionEvent());
    }
  }
}
