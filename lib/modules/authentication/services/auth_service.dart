import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/core/services/local_storage.dart';
import 'package:todo_list/modules/authentication/exceptions/auth_exception.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("Ocorreu um erro");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      setLocalUserInfos(credential.user!);

      return credential.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        String message = AuthExceptions.handleAuthException(e);
        throw AuthExceptions(message: message);
      }
    }
    return null;
  }

  void setLocalUserInfos(User user) async {
    final localStorage = LocalStorageService();
    String? token = await user.getIdToken();
    String? userEmail = user.email;

    if (token != null) localStorage.setAuthToken(token);
    if (userEmail != null) localStorage.setUserEmail(userEmail);
  }
}
