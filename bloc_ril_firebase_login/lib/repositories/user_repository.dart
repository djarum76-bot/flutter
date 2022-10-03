import 'package:bloc_ril_firebase_login/models/user_model.dart';
import 'package:bloc_ril_firebase_login/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository{
  UserRepository({
    FirebaseFirestore? firebaseFirestore
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  Future<void> createUser(String uid, String username, String email)async{
    try{
      await _firebaseFirestore.collection(Constants.usersCollection).doc(uid).set({
        Constants.uid : uid,
        Constants.username : username,
        Constants.email : email
      });
    }on FirebaseException catch(e){
      throw Exception(e);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<UserModel> getUser(String uid)async{
    try{
      final userModel = await _firebaseFirestore.collection(Constants.usersCollection).doc(uid).get();
      return UserModel.fromJson(userModel.data()!);
    }on FirebaseException catch(e){
      throw Exception(e);
    }catch(e){
      throw Exception(e);
    }
  }
}