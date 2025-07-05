import 'package:notification/local_notifications.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  static Workmanager workManager = Workmanager();
  static Future<void> init() async {
    await workManager.initialize(callbackDispatcher, isInDebugMode: true);
    await registerMyTask();
  }

  static Future<void> registerMyTask() async {
    await workManager.registerPeriodicTask(
      'uniqueName',
      'taskName',
      frequency: Duration(seconds: 15),
    );
  }

  static Future<void> cancelTask(String taskId) async {
    await workManager.cancelByUniqueName(taskId);
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    LocalNotification.showBasicNotification();
    return await Future.value(true);
  });
}
