import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigationv2/di/injector.dart';
import 'package:navigationv2/domain/usescases/auth/is_logged_usecase.dart';
import 'package:navigationv2/presentation/home/content/my_notifications_page.dart';
import 'package:navigationv2/presentation/home/content/my_purchases_page.dart';
import 'package:navigationv2/presentation/home/content/profile_page.dart';
import 'package:navigationv2/presentation/home/home_page.dart';
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
      // Al dia de hoy el ShellRoute tiene muchos problemas para navegar a el
      // por lo que no recomiendo usarlo en producción
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (ctx, state, child) => HomePage(child: child),
        routes: [
          GoRoute(
            path: "purchases",
            builder: (ctx, state) => const MyPurchasesPage(),
          ),
          GoRoute(
            path: "notifications",
            builder: (ctx, state) => const MyNotificationsPage(),
          ),
          GoRoute(
            path: "profile",
            builder: (ctx, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
    redirect: (ctx, state) async {
      final isLoggedUseCase = getIt<IsLoggedUseCase>();
      final location = state.location;

      if (location == "/login" || isLoggedUseCase()) {
        return null; // No requiere redireccionar, sigue el camino normal
      }
      return "/login";
    });
