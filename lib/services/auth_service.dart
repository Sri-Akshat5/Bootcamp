import 'package:bootcamp/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helper/helper_function.dart';

class AuthService {
  final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  // login

  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await fireBaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      return true;
    } on FirebaseAuthException catch (e) {
      print(e);

      return e.message;
    }
  }

  //Register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await fireBaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      await DatabaseService(uid: user.uid).savingUserData(fullName, email);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);

      return e.message;
    }
  }

  // SIgnout

  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailSF("");
      await HelperFunction.saveUserNameSF("");
      await fireBaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
