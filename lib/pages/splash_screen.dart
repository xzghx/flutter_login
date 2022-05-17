import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_project/authentication/bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/splashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    changeState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> changeState(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<AuthenticationBloc>().add(const AuthenticationStatusChanged(
        AuthenticationStatus.unAuthenticated));
  }
}
