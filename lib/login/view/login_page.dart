import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_project/login/bloc/login_bloc.dart';
import 'package:login_bloc_project/repositories/user_repository.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static const String route = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(0),
        child: BlocProvider(
            create: (context) => LoginBloc(
                userRepo: RepositoryProvider.of<UserRepository>(context))
        ,child: const LoginForm(),
        ),

      ),
    );
  }
}

