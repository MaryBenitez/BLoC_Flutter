import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

//Autenticación no inicializada
//---->> esperando para ver si el usuario está autenticado o no en el inicio de la aplicación.
class AuthenticationUninitialized extends AuthenticationState {}

//Autenticación Autenticada
class AuthenticationAuthenticated extends AuthenticationState {}

//Autenticación No autenticada
class AuthenticationUnauthenticated extends AuthenticationState {}

//Carga de autenticación
//--->> esperando para persistir / eliminar un token
class AuthenticationLoading extends AuthenticationState {}