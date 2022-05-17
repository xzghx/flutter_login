import 'package:login_bloc_project/models/user.dart';

class UserRepository {
  Future<User> logIn(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return const User(id: 1, name: "Zahra", lastName: "Gh");
  }

  Future<User> getUser() async {
    return const User(id: 1, name: "Zahra", lastName: "Gh");
  }

  void logOut() {
    return;
  }
}
