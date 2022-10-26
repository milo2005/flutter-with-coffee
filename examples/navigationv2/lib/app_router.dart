import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigationv2/di/injector.dart';
import 'package:navigationv2/domain/usescases/auth/is_logged_usecase.dart';
import 'package:navigationv2/presentation/login/login_page.dart';
import 'package:navigationv2/presentation/products/products_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: "/products",
    routes: [
      GoRoute(path: "/login", builder: (ctx, state) => const LoginPage()),
      productsRouter,
    ],
    redirect: (ctx, state) async {
      final isLoggedUseCase = getIt<IsLoggedUseCase>();
      final location = state.location;

      if (location == "/login" || isLoggedUseCase()) {
        return null; // No requiere redireccionar, sigue el camino normal
      }
      return "/login";
    });
