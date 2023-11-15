import 'package:firebase_auth/firebase_auth.dart';

class AuthExceptions implements Exception {
  final String message;

  AuthExceptions({
    required this.message,
  });

  static String handleAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case "invalid-email":
        return "O endereço de e-mail está mal formatado.";
      case "user-not-found":
        return "Não há nenhum usuário correspondente ao endereço de e-mail fornecido.";
      case "wrong-password":
        return "A senha fornecida está incorreta.";
      case "user-disabled":
        return "O usuário correspondente ao e-mail fornecido foi desativado.";
      default:
        return "Um erro desconhecido ocorreu: ${exception.message}";
    }
  }
}
