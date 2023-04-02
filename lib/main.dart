import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jacopo_flutter_test/core/injector_widget.dart';
import 'package:jacopo_flutter_test/core/jacopo_flutter_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const injector = InjectorWidget(child: DependencyProvider());
  await injector.init();
  runApp(injector);
}

typedef BlocCreator<T extends Bloc> = T Function(BuildContext);

class DependencyProvider extends StatelessWidget {
  const DependencyProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: (BuildContext ctx) {
            return InjectorWidget.of(context).getApiariesBloc();
          },
        ),
        RepositoryProvider.value(
          value: (BuildContext ctx) {
            return InjectorWidget.of(context).getHivesBloc();
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (ctx) => InjectorWidget.of(context).getUserBloc(),
              ),
            ],
            child: const JacopoFlutterApp(),
          );
        },
      ),
    );
  }
}
