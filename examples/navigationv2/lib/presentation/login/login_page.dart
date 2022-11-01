import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navigationv2/di/injector.dart';
import 'package:navigationv2/presentation/login/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<LoginBloc>(),
        child: const _LoginPageContent(),
      ),
    );
  }
}

class _LoginPageContent extends StatelessWidget {
  const _LoginPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (ctx, state) => ctx.replace("/"),
      builder: (ctx, state) => _setContentState(ctx, state),
    );
  }

  Widget _setContentState(BuildContext ctx, LoginState state) {
    switch (state) {
      case LoginState.loading:
        return _setLoadingState();
      default:
        return _setFormState(ctx);
    }
  }

  Widget _setLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _setFormState(BuildContext ctx) {
    final textTheme = Theme
        .of(ctx)
        .textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Iniciar Sesion", style: textTheme.subtitle2,
            textAlign: TextAlign.center,),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => BlocProvider.of<LoginBloc>(ctx).login(),
            child: const Text("Entrar"),)
        ],
      ),
    );
  }


}
