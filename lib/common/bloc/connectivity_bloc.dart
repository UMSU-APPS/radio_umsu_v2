import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'connectivity_state.dart';
import 'connectivity_event.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckInitialConnectivity>(_onInitialCheck);
    on<ConnectivityChanged>(_onConnectivityChanged);

    // Lakukan pengecekan awal
    add(CheckInitialConnectivity());

    // Dengarkan perubahan koneksi
    _subscription = _connectivity.onConnectivityChanged.listen(
      (result) => add(ConnectivityChanged(result)),
    );
  }

  Future<void> _onInitialCheck(
      CheckInitialConnectivity event, Emitter<ConnectivityState> emit) async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      emit(ConnectivityFailure());
    } else {
      emit(ConnectivitySuccess(result));
    }
  }

  void _onConnectivityChanged(
      ConnectivityChanged event, Emitter<ConnectivityState> emit) {
    final result = event.result;
    if (result.contains(ConnectivityResult.none)) {
      emit(ConnectivityFailure());
    } else {
      emit(ConnectivitySuccess(result));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
