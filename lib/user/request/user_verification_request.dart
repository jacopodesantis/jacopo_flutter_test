import 'package:jacopo_flutter_test/core/jacopo_request.dart';

class UserVerificationRequest extends JacopoRequest {
  final String token;

  const UserVerificationRequest({required this.token});

  @override
  String get endpoint => '/auth/jwt/verify/';

  @override
  Map<String, dynamic> get body => {
        'token': token,
      };
}
