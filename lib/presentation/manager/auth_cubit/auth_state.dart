part of 'auth_cubit.dart';

abstract class AuthState {}

final class AuthCubitInitial extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  String errMessage;
  LoginFailure({required this.errMessage});
}

final class SginupLoading extends AuthState {}

final class SginupSuccess extends AuthState {}

final class SginupFailure extends AuthState {
  String errMessage;
  SginupFailure({required this.errMessage});
}
