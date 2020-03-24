import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

//Es el estado inicial de LoginForm.
class LoginInitial extends LoginState {}

//Es el estado de LoginForm cuando validamos credenciales
class LoginLoading extends LoginState {}

//Es el estado de LoginForm cuando falla un intento de inicio de sesión.
class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
