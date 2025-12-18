import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_umsu/common/routes/names.dart';
import 'package:radio_umsu/pages/music/bloc/music_bloc.dart';
import 'package:radio_umsu/pages/music/music_screen.dart';

List<PageIdentity> routes() {
  return [
    // PageIdentity(
    //   route: AppRoutes.initial,
    //   page: const OnboardingScreen(),
    //   bloc: BlocProvider(create: (_) => OnboardingBloc()),
    // ),
    // PageIdentity(
    //   route: AppRoutes.application,
    //   page: const ApplicationScreen(),
    //   bloc: BlocProvider(create: (_) => ApplicationBloc()),
    // ),
    PageIdentity(
      route: AppRoutes.music,
      page: const MusicScreen(),
      bloc: BlocProvider(create: (_) => MusicBloc()),
    ),
  ];
}

class PageIdentity {
  String route;
  Widget page;
  dynamic bloc;

  PageIdentity({required this.route, required this.page, this.bloc});
}
