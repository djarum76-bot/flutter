import 'package:firebase_auth/firebase_auth.dart';

class SignUpFailure implements Exception{
  const SignUpFailure([
    this.message = 'An unknown error occured'
  ]);

  final String message;

  factory SignUpFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpFailure();
    }
  }
}

class LogInFailure implements Exception {
  const LogInFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  final String message;

  factory LogInFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInFailure();
    }
  }
}

class LogOutFailure implements Exception{}

class AuthRepository{
  AuthRepository({
    FirebaseAuth? firebaseAuth
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Future<void> signUp(String email, String password)async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await user!.updateDisplayName(email.split('@').first);
      await user.updatePhotoURL("https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png");
    }on FirebaseAuthException catch(e){
      throw SignUpFailure.fromCode(e.code);
    }catch(_){
      throw SignUpFailure();
    }
  }

  Future<void> logIn(String? email, String? password)async{
    assert(email != null && password != null);
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
    }on FirebaseAuthException catch(e){
      throw LogInFailure.fromCode(e.code);
    }catch(_){
      throw LogInFailure();
    }
  }

  Future<void> logOut()async{
    try{
      await _firebaseAuth.signOut();
    }on Exception{
      throw LogOutFailure();
    }
  }

  User? getUser(){
    final user = _firebaseAuth.currentUser;
    return user;
  }
}