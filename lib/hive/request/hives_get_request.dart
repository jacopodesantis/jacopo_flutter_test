import 'package:jacopo_flutter_test/core/jacopo_request.dart';

class HivesGetRequest extends JacopoRequest {
  final int apiaryId;

  const HivesGetRequest({required this.apiaryId});

  @override
  String get endpoint => '/apiaries/$apiaryId/hives';
}
