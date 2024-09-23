import 'package:bloc/bloc.dart';
import 'package:chat_app/core/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

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
}
