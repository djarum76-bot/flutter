import 'package:bloc_firebase_login/models/user_model.dart';
import 'package:bloc_firebase_login/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository{
  UserRepository({
    FirebaseFirestore? firebaseFirestore
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  Future<void> createUser(UserModel userModel)async{
    try{
      await _firebaseFirestore.collection(Constants.usersCollection)
          .doc(userModel.id)
          .set(userModel.toJson());
    }catch(e){
      throw Exception(e);
    }
  }

  Future<UserModel> getUserById(String id)async{
    try{
      final result = await _firebaseFirestore.collection(Constants.usersCollection).doc(id).get();
      return UserModel.fromJson(result.data()!);
    }catch(e){
      throw Exception(e);
    }
  }
}