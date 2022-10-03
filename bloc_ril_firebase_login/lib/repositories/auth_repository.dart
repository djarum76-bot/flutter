import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository{
  AuthRepository({
    FirebaseAuth? firebaseAuth
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Future<void> signUp(String email, String password)async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      throw Exception(e);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> signIn(String email, String password)async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      throw Exception(e);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> signOut()async{
    try{
      if(await GoogleSignIn().isSignedIn()){
        await GoogleSignIn().signOut();
      }
      await _firebaseAuth.signOut();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> signInWithGoogle()async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      await _firebaseAuth.signInWithCredential(credential);
    }on FirebaseAuthException catch(e){
      throw Exception(e);
    }catch(e){
      throw Exception(e);
    }
  }
}