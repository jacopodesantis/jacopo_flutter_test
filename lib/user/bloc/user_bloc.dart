import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jacopo_flutter_test/core/storage_repository.dart';
import 'package:jacopo_flutter_test/user/request/user_login_request.dart';
import 'package:jacopo_flutter_test/user/request/user_verification_request.dart';
import 'package:jacopo_flutter_test/user/service/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  final StorageRepository _storage;

  String? token;

  UserBloc(
    this.userService,
    StorageRepository storage,
  )   : _storage = storage,
        super(AuthenticationInitial()) {
    on<UserInitialize>((event, emit) async {
      await _verifyStorage(emit);
    });
    on<UserLoggingIn>((event, emit) async {
      await _loginUser(emit, event);
    });
    on<UserLoggingOut>((event, emit) async {
      await _logoutUser(emit);
    });
  }

  // Future<void> _resetToken(Emitter<UserState> emit) async {
  //   emit(UserLoading());
  //   await _deleteToken();
  //   emit(UserUnauthenticated());
  // }

  Future<void> _verifyStorage(Emitter<UserState> emit) async {
    emit(UserLoading());
    final storageToken = await _storage.read('token');
    final storageRefresh = await _storage.read('refresh');
    token = storageToken;
    if (storageToken != null && storageRefresh != null) {
      final user = await _verifyToken(storageToken);
      if (user != null) {
        emit(UserAuthenticated(token: storageToken));
      } else {
        emit(UserUnauthenticated());
      }
    }
    emit(UserUnauthenticated());
  }

  Future<String?> _verifyToken(String token) async {
    try {
      final result =
          await userService.verifyToken(UserVerificationRequest(token: token));
      if (!result.hasFailed && result.value != null) {
        return token;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _loginUser(Emitter<UserState> emit, UserLoggingIn event) async {
    String? token;
    emit(UserLoading());
    try {
      var result = await userService.login(
        UserLoginRequest(
          email: event.email,
          password: event.pw,
        ),
      );
      if (!result.hasFailed && result.value != null) {
        token = result.value!.token;
        if (token != '') {
          await _deleteToken();
          await _writeToken(token);
          emit(UserAuthenticated(token: token));
        } else {
          emit(
            UserAuthenticationError(),
          );
        }
      } else {
        emit(
          UserAuthenticationError(),
        );
      }
    } catch (e) {
      emit(UserWrongCredentials());
    }
  }

  // _updateToken(Emitter<UserState> emit, {required String newToken}) async {
  //   emit(UserLoading());
  //   await _deleteToken();
  //   await _writeToken(newToken);
  //   emit(UserAuthenticated(token: newToken));
  // }

  Future<void> _deleteToken() async {
    await _storage.delete('token');
    token = null;
  }

  Future<void> _writeToken(String token) async {
    await _storage.write('token', token);
    token = token;
  }

  Future<void> _logoutUser(Emitter<UserState> emit) async {
    emit(UserLogoutLoading());

    await _deleteToken();
    emit(UserUnauthenticated());
  }
}
