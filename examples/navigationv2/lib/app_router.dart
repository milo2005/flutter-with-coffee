import 'package:go_router/go_router.dart';
import 'package:navigationv2/di/injector.dart';
import 'package:navigationv2/domain/usescases/auth/is_logged_usecase.dart';
import 'package:navigationv2/presentation/home/home_router.dart';
import 'package:navigationv2/presentation/login/login_page.dart';
import 'package:navigationv2/presentation/products/products_router.dart';

final GoRouter appRouter = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(path: "/login", builder: (ctx, state) => const LoginPage()),
      ...homeRouter,
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
