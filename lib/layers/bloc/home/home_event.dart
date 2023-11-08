abstract class LoadMusicEvent{}

class InitMusicEvent extends LoadMusicEvent{}

class NoPermissionEvent extends LoadMusicEvent{}

class GainedPermissionEvent extends LoadMusicEvent{}

class SetMusicEvent extends LoadMusicEvent{}

class PlayMusicEvent extends LoadMusicEvent{}

class PauseMusicEvent extends LoadMusicEvent{}