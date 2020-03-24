import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

//Se enviará cuando la aplicación Flutter se cargue por primera vez.
//Notificará al bloque que necesita determinar si hay o no un usuario existente.
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

//Será enviado en un inicio de sesión exitoso.
//Notificará al bloque que el usuario ha iniciado sesión correctamente.
class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';
}

//Será enviado en un cierre de sesión exitoso.
//Notificará al bloque que el usuario ha cerrado la sesión correctamente.
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'Loggedout';
}
