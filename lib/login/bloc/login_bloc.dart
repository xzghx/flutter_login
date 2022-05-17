import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:login_bloc_project/login/models/models.dart';
import 'package:login_bloc_project/repositories/user_repository.dart';

import '../../models/user.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepo;

  LoginBloc({required this.userRepo}) : super(const LoginState()) {
    on<LoginUserNameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  FutureOr<void> _onUsernameChanged(
      LoginUserNameChanged event, Emitter<LoginState> emit) {
    UserName userName = UserName.dirty(event.userName);
    emit(state.copyWith(
        userName: userName,
        formzStatus: Formz.validate([userName, state.password])));
  }

  FutureOr<void> _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final Password password = Password.dirty(event.password);

    emit(state.copyWith(
        password: password,
        formzStatus: Formz.validate([password, state.userName])));
  }

  FutureOr<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.formzStatus.isValidated) {
      emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
      User user =
          await userRepo.logIn(state.userName.value, state.password.value);
      if (user != null) {
        emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
      }
    }
  }
}
