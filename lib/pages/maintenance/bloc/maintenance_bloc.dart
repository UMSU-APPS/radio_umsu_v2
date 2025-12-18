import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_umsu/pages/maintenance/bloc/maintenance_event.dart';
import 'package:radio_umsu/pages/maintenance/bloc/maintenance_state.dart';

class MaintenanceBloc extends Bloc<MaintenanceEvent, MaintenanceState> {
  MaintenanceBloc() : super(MaintenanceState()) {
    return;
  }
}
