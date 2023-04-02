import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacopo_flutter_test/apiary/bloc/apiaries_bloc.dart';
import 'package:jacopo_flutter_test/apiary/cubit/apiaries_counter_cubit.dart';
import 'package:jacopo_flutter_test/hive/bloc/hives_bloc.dart';
import 'package:jacopo_flutter_test/home/views/home_page.dart';
import 'package:jacopo_flutter_test/intro/views/intro_page.dart';
import 'package:jacopo_flutter_test/main.dart';
import 'package:jacopo_flutter_test/user/bloc/user_bloc.dart';

class JacopoFlutterApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const JacopoFlutterApp({Key? key}) : super(key: key);

  static Widget buildApp({
    Widget home = const IntroPage(),
    UserBloc? userBloc,
    List<NavigatorObserver> navigatorObservers = const [],
  }) {
    final Map<String, Widget Function(BuildContext)> routes = {
      HomePage.routeName: (ctx) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: RepositoryProvider.of<BlocCreator<ApiariesBloc>>(ctx),
              ),
              BlocProvider(
                create: RepositoryProvider.of<BlocCreator<HivesBloc>>(ctx),
              ),
              BlocProvider(
                create: (context) => ApiariesCounterCubit(),
              ),
            ],
            child: const HomePage(),
          ),
    };
    return MaterialApp(
      title: '3 Bee App',
      navigatorKey: JacopoFlutterApp.navigatorKey,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        );
      },
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        if (arguments is AppRouteArguments) {
          settings = RouteSettings(
            name: settings.name,
            arguments: settings.arguments,
          );
        }

        return MaterialPageRoute(
          builder: routes[settings.name]!,
          settings: settings,
        );
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primaryColor: const Color.fromRGBO(255, 176, 0, 1),
        disabledColor: Colors.grey,
        backgroundColor: const Color.fromRGBO(39, 37, 37, 1),
        bottomAppBarColor: const Color.fromRGBO(214, 33, 41, 1),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: home,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    if (userBloc.state is AuthenticationInitial) {
      userBloc.add(UserInitialize());
    }

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserUnauthenticated) {
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const IntroPage(),
            ),
            (route) => false,
          );
        }
      },
      listenWhen: (previous, current) {
        return ((previous is UserLogoutLoading) ||
            (previous is UserLoading && current is UserAuthenticated));
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: JacopoFlutterApp.buildApp(
          home: const IntroPage(),
        ),
      ),
    );
  }
}

class AppRouteArguments extends RouteSettings {
  const AppRouteArguments({String? name, Object? arguments})
      : super(name: name, arguments: arguments);
}
