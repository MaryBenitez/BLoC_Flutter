import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patronbloc/bloc/authenticationBloc.dart';
import 'package:patronbloc/estados/authentication.dart';
import 'package:patronbloc/eventos/authenticationEvent.dart';
import 'package:patronbloc/extras/loadingPage.dart';
import 'package:patronbloc/extras/splashPage.dart';
import 'package:patronbloc/paginas/homepage.dart';
import 'package:patronbloc/paginas/loginPage.dart';
import 'package:patronbloc/repositorios/userRepository.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc authenticationBloc;
  UserRepository get userRespository => widget.userRepository;

  get userRepository => null;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRespository);
    authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationUninitialized) {
                return SplashPage();
              }
              if (state is AuthenticationAuthenticated) {
                return HomePage();
              }
              if (state is AuthenticationUnauthenticated) {
                return LoginPage(userRepository: userRepository);
              }
              if(state is AuthenticationLoading){
                return LoadingIndicator();
              }
            }),
      ),
    );
  }
}
