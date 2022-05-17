part of 'login_bloc.dart';

class LoginState extends Equatable {
  final UserName userName;

  final Password password;

  final FormzStatus formzStatus;

  const LoginState({
    this.userName = const UserName.pure(),
    this.password = const Password.pure(),
    this.formzStatus = FormzStatus.pure,
  });

  LoginState copyWith(
      {UserName? userName, Password? password, FormzStatus? formzStatus}) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      formzStatus: formzStatus ?? this.formzStatus,
    );
  }

  @override
  List<Object?> get props => [userName, password, formzStatus];
}
