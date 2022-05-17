import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:login_bloc_project/login/bloc/login_bloc.dart';

import '../../pages/home_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formzStatus == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text("Login Error")));
        }
        else if (state.formzStatus == FormzStatus.submissionSuccess) {
          Navigator.of(context).pushNamed(HomePage.route);
        }
      },
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.redAccent.shade100,
          ),
          Align(
            alignment: const Alignment(0, -1 / 2),
            child: SizedBox(
              width: 500,
              height: 400,
              child: Card(
                elevation: 30,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _UsernameInput(),
                      const Padding(padding: EdgeInsets.all(12)),
                      _PasswordInput(),
                      const Padding(padding: EdgeInsets.all(12)),
                      _LoginButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.userName != current.userName,
      builder: (context, state) {
        return TextField(
          onChanged: (String value) {
            context.read<LoginBloc>().add(LoginUserNameChanged(value));
          },
          decoration: InputDecoration(
            labelText: "UserName",
            errorText: state.userName.invalid ? "Invalid userName" : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (String value) {
            context.read<LoginBloc>().add(LoginPasswordChanged(value));
          },
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            errorText: state.password.invalid ? "Invalid Password" : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) =>
            previous.formzStatus != current.formzStatus,
        builder: (context, state) {
          if (state.formzStatus == FormzStatus.submissionInProgress) {
            return const CircularProgressIndicator();
          } else {
            return ElevatedButton(
                onPressed: state.formzStatus.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: const Text("Login"));
          }
        });
  }
}
