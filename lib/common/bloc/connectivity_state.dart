import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivitySuccess extends ConnectivityState {
  final List<ConnectivityResult> connectionTypes;

  ConnectivitySuccess(this.connectionTypes);
}

class ConnectivityFailure extends ConnectivityState {}
