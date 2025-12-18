part of 'music_bloc.dart';

@immutable
sealed class MusicEvent {}

class TriggerLoadingEvent extends MusicEvent {}

class MusicDataLoadedEvent extends MusicEvent {
  final List<RadioConfig> data;
  MusicDataLoadedEvent(this.data);
}

class MusicErrorEvent extends MusicEvent {
  final String message;
  MusicErrorEvent(this.message);
}

class MusicPlayerStatusChanged extends MusicEvent {
  final bool isPlaying;
  MusicPlayerStatusChanged(this.isPlaying);
}
