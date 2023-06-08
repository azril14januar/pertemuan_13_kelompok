// ignore_for_file: non_constant_identifier_names

import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:pertemuan_11/pages/home_pages.dart';

class AppRoutes {
  static const home = "home";

  // ignore: avoid_types_as_parameter_names
  static Page _homePageBuilder(BuildContext context, GoRouterState) {
    return const MaterialPage(
      child: HomePage(),
    );
  }

  static GoRouter goRouter = GoRouter(initialLocation: "/home", routes: [
    GoRoute(
      name: home,
      path: "/home",
      pageBuilder: _homePageBuilder,
    ),
  ]);
}
