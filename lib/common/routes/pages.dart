import 'package:flutter/material.dart';
import 'package:radio_umsu/common/routes/indentity.dart';
import 'package:radio_umsu/common/routes/names.dart';
import 'package:radio_umsu/pages/maintenance/maintenance_screen.dart';
import 'package:radio_umsu/pages/music/music_screen.dart';

class AppPages {
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name == AppRoutes.initial || settings.name == '/') {
      return MaterialPageRoute(
        builder: (_) => const MusicScreen(),
        settings: settings,
      );
    }

    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);

      if (result.isNotEmpty) {
        return MaterialPageRoute(
          builder: (_) => result.first.page,
          settings: settings,
        );
      }
    }

    print("Route not found: ${settings.name}, redirecting to Maintenance.");
    return MaterialPageRoute(
      builder: (_) => const MaintenanceScreen(),
      settings: settings,
    );
  }
}
