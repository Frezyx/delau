import 'package:delau/utils/provider/own_api/middleware/marker.dart';
import 'package:delau/utils/provider/own_api/middleware/task.dart';
import 'package:delau/utils/provider/own_api/middleware/user.dart';

class API {
  API._();

  static final API api = API._();
  static final TaskHandler taskHandler = TaskHandler();
  static final UserHandler userHandler = UserHandler();
  static final MarkerHandler markerHandler = MarkerHandler();
}
