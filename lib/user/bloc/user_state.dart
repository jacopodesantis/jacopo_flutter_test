part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends UserState {}

class UserAuthenticated extends UserState {
  final String token;

  const UserAuthenticated({required this.token});

  @override
  List<Object> get props => [token];
}

class UserLoading extends UserState {}

class UserAuthenticationLoading extends UserState {}

class UserUnauthenticated extends UserState {}

class UserAuthenticationError extends UserState {}

class UserWrongCredentials extends UserState {}

class UserLogoutLoading extends UserState {}
