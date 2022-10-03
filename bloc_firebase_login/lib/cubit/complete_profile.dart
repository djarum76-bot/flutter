import 'package:bloc_firebase_login/models/user_model.dart';
import 'package:bloc_firebase_login/repositories/user_repository.dart';
import 'package:bloc_firebase_login/utils/validators/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CompleteProfileState extends Equatable{
  const CompleteProfileState({
    this.name = const DefaultValidator.pure(),
    this.status = FormzStatus.pure
  });

  final DefaultValidator name;
  final FormzStatus status;

  @override
  List<Object?> get props => [name, status];

  CompleteProfileState copyWith({
    DefaultValidator? name,
    FormzStatus? status
  }) {
    return CompleteProfileState(
      name: name ?? this.name,
      status: status ?? this.status
    );
  }
}

class CompleteProfileCubit extends Cubit<CompleteProfileState>{
  CompleteProfileCubit() : super(const CompleteProfileState());

  final UserRepository _userRepository = UserRepository();

  void nameChanged(String value){
    final name = DefaultValidator.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name
      ])
    ));
  }

  Future<void> submit()async{
    if(!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final userModel = UserModel(
        id: uid,
        name: state.name.value,
      );

      await _userRepository.createUser(userModel);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(_){
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}