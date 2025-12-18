part of 'music_bloc.dart';

enum MusicStatus { initial, loading, success, failure }

class MusicState {
  final MusicStatus status;
  final List<RadioConfig> radioList;
  final String errorMessage;
  final bool isPlaying;

  const MusicState({
    this.status = MusicStatus.initial,
    this.radioList = const [],
    this.errorMessage = "",
    this.isPlaying = false,
  });

  RadioConfig? get currentRadio =>
      radioList.isNotEmpty ? radioList.first : null;

  MusicState copyWith({
    MusicStatus? status,
    List<RadioConfig>? radioList,
    String? errorMessage,
    bool? isPlaying,
  }) {
    return MusicState(
      status: status ?? this.status,
      radioList: radioList ?? this.radioList,
      errorMessage: errorMessage ?? this.errorMessage,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
