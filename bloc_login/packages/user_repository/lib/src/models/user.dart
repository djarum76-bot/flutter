import 'package:equatable/equatable.dart';

class User extends Equatable{
  const User(this.id);

  final String id;

  @override
  // TODO: implement props
  List<Object> get props => [id];

  static const empty = User('-');
}