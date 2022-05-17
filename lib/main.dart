import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/bloc/authentication_bloc.dart';
import '../home/home_page.dart';
import '../repositories/user_repository.dart';
import 'login/view/view.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(MyApp(userRepo: UserRepository()));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepo;

  const MyApp({required this.userRepo, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: userRepo,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(userRepo: userRepo),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (_, state) {
            if (state.status == AuthenticationStatus.unknown) {
              // Navigator.of(context).pushNamed(SplashScreen.route);
              _navigator.pushReplacementNamed(SplashScreen.route);
            }
            if (state.status == AuthenticationStatus.unAuthenticated) {
              // Navigator.of(context).pushNamed(LoginPage.route);
              _navigator.pushReplacementNamed(LoginPage.route);
            } else {
              // Navigator.of(context).pushNamed(HomePage.route);
              _navigator.pushReplacementNamed(HomePage.route);
            }
          },
          child: child,
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    Object? args = settings.arguments;
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case LoginPage.route:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case SplashScreen.route:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
    return null;
  }
}
