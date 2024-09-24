import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sginup_state.dart';

class SginupCubit extends Cubit<SginupState> {
  SginupCubit() : super(SginupInitial());

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(SginupLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      emit(SginupSuccess());
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        emit(SginupFailure(errMessage: 'weak password'));
      } else if (error.code == 'email-already-in-use') {
        emit(SginupFailure(errMessage: 'email already inuse'));
      }
    } catch (e) {
      emit(SginupFailure(errMessage: e.toString()));
    }
  }
}
