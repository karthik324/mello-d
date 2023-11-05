import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mello_d/layers/bloc/home/home_event.dart';
import 'package:mello_d/layers/bloc/home/home_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicBloc extends Bloc<LoadMusicEvent, MusicState> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  bool hasPermission = false;

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
    } catch (e) {
      print(e.toString());
    }
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
