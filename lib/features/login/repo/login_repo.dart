import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/features/login/model/login_model.dart';

class LoginRepo {
  // METHOD WITHOUT MODEL CLASS
  // Future<void> login({required String email, required String password}) {}
  Future<UserCredential> login({required LoginModel loginModel}) async {
    // ALWAYS USE TRY-CATCH
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: loginModel.email, password: loginModel.password);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message.toString());
    }
  }
}
