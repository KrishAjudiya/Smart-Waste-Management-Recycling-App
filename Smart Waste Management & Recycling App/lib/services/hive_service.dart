import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static const String OFFLINE_ACTIONS_BOX = 'offline_actions';

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox(OFFLINE_ACTIONS_BOX);
  }

  Future<void> saveOfflineAction(Map<String, dynamic> actionData) async {
    final box = Hive.box(OFFLINE_ACTIONS_BOX);
    await box.add(actionData);
  }

  List<Map<String, dynamic>> getOfflineActions() {
    final box = Hive.box(OFFLINE_ACTIONS_BOX);
    return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> clearOfflineActions() async {
    final box = Hive.box(OFFLINE_ACTIONS_BOX);
    await box.clear();
  }
}
