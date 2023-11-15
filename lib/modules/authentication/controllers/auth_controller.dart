import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/modules/authentication/services/auth_service.dart';

class AuthController {
  final AuthService authService = AuthService();

  Future<User?> signUp(String email, String password) async {
    return await authService.signUpWithEmailAndPassword(email, password);
  }

  Future<User?> signIn(String email, String password) async {
    return await authService.signInWithEmailAndPassword(email, password);
  }
}
