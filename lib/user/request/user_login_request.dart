import 'package:jacopo_flutter_test/core/jacopo_request.dart';

class UserLoginRequest extends JacopoRequest {
  final String email;
  final String password;

  const UserLoginRequest({
    required this.email,
    required this.password,
  });

  @override
  String get endpoint => '/auth/jwt/create/';

  @override
  Map<String, dynamic> get body => {
        'email': email,
        'password': password,
      };
}
