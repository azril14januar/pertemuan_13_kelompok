// ignore_for_file: non_constant_identifier_names

import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:pertemuan_11/pages/home_pages.dart';
import 'package:pertemuan_11/pages/post_pages.dart';

import '../models/post.dart';

class AppRoutes {
  static const home = "home";
  static const post = "post";

  // ignore: avoid_types_as_parameter_names
  static Page _homePageBuilder(BuildContext context, GoRouterState) {
    return const MaterialPage(
      child: HomePage(),
    );
  }

  static Page _postPageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: PostPage(
        post: state.extra as Post,
      ),
    );
  }

  static GoRouter goRouter = GoRouter(initialLocation: "/home", routes: [
    GoRoute(
      name: home,
      path: "/home",
      pageBuilder: _homePageBuilder,
      routes: [
        GoRoute(
          name: post,
          path: "path",
          pageBuilder: _postPageBuilder,
        ),
      ]
    ),
  ]);
}
