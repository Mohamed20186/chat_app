import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthCubitInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'user not found'));
      } else if (error.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'wrong-password'));
      } else {
        emit(LoginFailure(errMessage: error.code));
      }
    } catch (error) {
      emit(LoginFailure(errMessage: 'login error'));
    }
  }

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

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change);
  }
}
