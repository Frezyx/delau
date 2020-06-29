import 'package:delau/utils/provider/own_api/middleware/task.dart';

class API {
  API._();

  static final API api = API._();
  static final TaskHandler taskHandler = TaskHandler();
}
