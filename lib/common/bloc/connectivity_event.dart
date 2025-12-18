// connectivity_event.dart
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityEvent {}

class CheckInitialConnectivity extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final List<ConnectivityResult> result;
  ConnectivityChanged(this.result);
}
