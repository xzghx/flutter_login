part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unAuthenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(
          user: user,
          status: AuthenticationStatus.authenticated,
        );

  const AuthenticationState.unAuthenticated()
      : this._(
          status: AuthenticationStatus.unAuthenticated,
        );

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object?> get props => [status, user];
}
