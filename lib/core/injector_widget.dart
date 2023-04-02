import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jacopo_flutter_test/apiary/bloc/apiaries_bloc.dart';
import 'package:jacopo_flutter_test/apiary/service/apiary_service.dart';
import 'package:jacopo_flutter_test/core/auth_interceptor.dart';
import 'package:jacopo_flutter_test/core/jacopo_api_client.dart';
import 'package:jacopo_flutter_test/core/storage_repository.dart';
import 'package:jacopo_flutter_test/hive/bloc/hives_bloc.dart';
import 'package:jacopo_flutter_test/hive/service/hives_service.dart';
import 'package:jacopo_flutter_test/user/bloc/user_bloc.dart';
import 'package:jacopo_flutter_test/user/service/user_service.dart';

class InjectorWidget extends InheritedWidget {
  const InjectorWidget({Key? key, required Widget child})
      : super(key: key, child: child);

  static InjectorWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InjectorWidget>()
        as InjectorWidget;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static late JacopoApiClient jacopoApiClient;
  static late StorageRepository storageRepository;
  static late UserBloc _userBloc;
  static late UserService userService;
  static late ApiariesService apiariesService;
  static late HivesService hivesService;

  init() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: JacopoApiClient.baseUrl,
        contentType: 'application/json',
      ),
    );

    jacopoApiClient = JacopoApiClient(dio: dio);
    storageRepository = StorageRepository();
    userService = UserService(jacopoApiClient);
    apiariesService = ApiariesService(jacopoApiClient);
    hivesService = HivesService(jacopoApiClient);
    _userBloc = UserBloc(userService, storageRepository);

    dio.interceptors.addAll(
      [
        AuthInterceptor(_userBloc),
      ],
    );
  }

  UserBloc getUserBloc() {
    return _userBloc;
  }

  ApiariesBloc getApiariesBloc() {
    return ApiariesBloc(apiariesService);
  }

  HivesBloc getHivesBloc() {
    return HivesBloc(hivesService);
  }
}
