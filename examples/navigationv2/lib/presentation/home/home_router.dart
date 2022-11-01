import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:navigationv2/presentation/home/home_page.dart';
import 'package:navigationv2/presentation/home/home_sections.dart';

const homeKey = ValueKey("/home");

final List<GoRoute> homeRouter = [
  GoRoute(
    path: "/",
    redirect: (ctx, state) => "/home/purchases",
  ),
  GoRoute(
    path: "/home",
    redirect: (ctx, state) => "/home/purchases",
  ),
  GoRoute(
    path: "/home/:section",
    builder: (ctx, state) {
      final section = state.params["section"];
      return HomePage(key: homeKey, section: HomeSection.fromRoute(section));
    },
  )
];
