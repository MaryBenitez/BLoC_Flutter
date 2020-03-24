import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:patronbloc/bloc/authenticationBloc.dart';
import 'package:patronbloc/estados/login.dart';
import 'package:patronbloc/eventos/authenticationEvent.dart';
import 'package:patronbloc/eventos/loginEvent.dart';
import 'package:patronbloc/repositorios/userRepository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  //Define su estado inicial como LoginInitial.
  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null), //---->>>Depende de UserRepository para autenticar a un usuario con un nombre de usuario y contraseña
        assert(authenticationBloc != null); //---->>>Depende de AuthenticationBloc para actualizar AuthenticationState cuando un usuario ha ingresado credenciales válidas

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
      LoginState currentState, LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
            username: event.username, password: event.password);

        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
