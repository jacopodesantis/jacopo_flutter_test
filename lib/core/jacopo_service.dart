import 'package:jacopo_flutter_test/core/jacopo_api_client.dart';

abstract class JacopoService {
  final JacopoApiClient client;

  const JacopoService(this.client);
}
