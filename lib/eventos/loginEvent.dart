import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

//Se enviará cuando un usuario presione el botón de inicio de sesión.
//Notificará al bloque que necesita solicitar un token para las credenciales dadas.
  LoginButtonPressed({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}
