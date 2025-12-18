import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:radio_umsu/common/entities/music_entities.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(const MusicState()) {
    on<TriggerLoadingEvent>((event, emit) {
      emit(state.copyWith(status: MusicStatus.loading));
    });

    on<MusicDataLoadedEvent>((event, emit) {
      emit(state.copyWith(status: MusicStatus.success, radioList: event.data));
    });

    on<MusicErrorEvent>((event, emit) {
      emit(
        state.copyWith(
          status: MusicStatus.failure,
          errorMessage: event.message,
        ),
      );
    });

    on<MusicPlayerStatusChanged>((event, emit) {
      emit(state.copyWith(isPlaying: event.isPlaying));
    });
  }
}
