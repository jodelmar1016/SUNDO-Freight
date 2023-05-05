import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freight/models/response.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FirebaseUser? _firebaseUser(User? user) {
  //   return user != null ? FirebaseUser(uid: user.uid) : null;
  // }

  // Stream<FirebaseUser?> get user {
  //   return _auth.authStateChanges().map(_firebaseUser);
  // }

  // Future signInAnonymous() async {
  //   try {
  //     UserCredential userCredential = await _auth.signInAnonymously();
  //     User? user = userCredential.user;
  //     return _firebaseUser(user);
  //   } catch (e) {
  //     return FirebaseUser(code: e.toString(), uid: null);
  //   }
  // }

  Future<Response> signInEmailPassword(String email, String password) async {
    Response response = new Response();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.toString(), password: password.toString());
      User? user = userCredential.user;
      print(user);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', user!.uid);
      response.code = 200;
      response.message = 'Successfully Login';
      return response;
    } on FirebaseAuthException catch (e) {
      response.code = 500;
      response.message = e.code;
      return response;
    }
  }

  Future<Response> registerEmailPassword(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    Response response = new Response();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.toString(), password: password.toString());

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(
            firstName.toString() + ' ' + lastName.toString());
        await user.reload();
        user = await _auth.currentUser;
      }

      response.code = 200;
      response.message = 'Account Created, you can now Login';
      return response;
      // User? user = userCredential.user;
      // return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      response.code = 500;
      response.message = e.code;
      return response;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
