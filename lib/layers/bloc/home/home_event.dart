abstract class LoadMusicEvent{}

class InitMusicEvent extends LoadMusicEvent{}

class NoPermissionEvent extends LoadMusicEvent{}

class GainedPermissionEvent extends LoadMusicEvent{}

class SetMusicEvent extends LoadMusicEvent{} 