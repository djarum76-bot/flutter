import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/utils/constants/local_constant.dart';

class LocalStorage{
  LocalStorage._(){
    _storage = const FlutterSecureStorage();
    _box = _initSecureBox;
  }

  static LocalStorage get instance => LocalStorage._();

  late final FlutterSecureStorage _storage;
  late final Future<Box> _box;

  Future<Box> get _initSecureBox async{
    String encryptedKey = await _storage.read(key: LocalConstant.encryptedKey) ?? "";

    if(encryptedKey.isEmpty){
      final key = Hive.generateSecureKey();
      await _storage.write(key: LocalConstant.encryptedKey, value: base64UrlEncode(key));
      encryptedKey = (await _storage.read(key: LocalConstant.encryptedKey))!;
    }

    final encryptionKeyUint8List = base64Url.decode(encryptedKey);
    return Hive.openBox(LocalConstant.box, encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  }

  Future<void> setData<T>(String key, T value)async{
    (await _box).put(key, value);
  }

  Future<void> deleteData()async{
    (await _box).delete(LocalConstant.token);
    (await _box).delete(LocalConstant.user);
  }

  Future<String> get token async => (await _box).get(LocalConstant.token) ?? "";

  Future<bool> get skipIntro async => (await _box).get(LocalConstant.skipIntro) ?? false;

  Future<UserModel> get user async => (await _box).get(LocalConstant.user);
}