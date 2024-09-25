import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email.trim(), password: event.password);
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
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
