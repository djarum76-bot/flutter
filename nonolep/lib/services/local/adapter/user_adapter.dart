import 'package:hive/hive.dart';
import 'package:nonolep/models/user_model.dart';

class UserAdapter extends TypeAdapter<UserModel>{
  @override
  UserModel read(BinaryReader reader) {
    final id = reader.readInt();
    final email = reader.readString();
    final gender = reader.readString();
    final age = reader.readInt();
    final weight = reader.readInt();
    final height = reader.readInt();
    final goalsLength = reader.readInt();
    final goals = List<String>.generate(goalsLength, (index) => reader.readString());
    final level = reader.readString();
    final picture = reader.readString();
    final name = reader.readString();
    final phone = reader.readString();
    final isFilled = reader.readBool();

    return UserModel(
      id: id,
      email: email,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      goals: goals,
      level: level,
      picture: picture,
      name: name,
      phone: phone,
      isFilled: isFilled,
    );
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeInt(obj.id ?? 0);
    writer.writeString(obj.email ?? '');
    writer.writeString(obj.gender ?? '');
    writer.writeInt(obj.age ?? 0);
    writer.writeInt(obj.weight ?? 0);
    writer.writeInt(obj.height ?? 0);
    writer.writeInt(obj.goals?.length ?? 0);
    obj.goals?.forEach((goal) => writer.writeString(goal));
    writer.writeString(obj.level ?? '');
    writer.writeString(obj.picture ?? '');
    writer.writeString(obj.name ?? '');
    writer.writeString(obj.phone ?? '');
    writer.writeBool(obj.isFilled ?? false);
  }
}