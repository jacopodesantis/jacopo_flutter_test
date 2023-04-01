part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserInitialize extends UserEvent {}

class UserLoggingOut extends UserEvent {
  final bool? isManualLogout;

  const UserLoggingOut({this.isManualLogout});
}

class UserLoggingIn extends UserEvent {
  final String email;
  final String pw;

  const UserLoggingIn({required this.email, required this.pw});

  @override
  List<Object> get props => [email, pw];
}
