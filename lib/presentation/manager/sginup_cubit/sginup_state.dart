part of 'sginup_cubit.dart';

abstract class SginupState {}

final class SginupInitial extends SginupState {}

final class SginupLoading extends SginupState {}

final class SginupSuccess extends SginupState {}

final class SginupFailure extends SginupState {
  String errMessage;
  SginupFailure({required this.errMessage});
}
