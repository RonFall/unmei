import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  Future<Box<dynamic>> _getAppBox() async => await Hive.openBox('appBox');

  Future<void> init() async {
    await Hive.initFlutter();
    await _getAppBox();
  }

  Future<void> set({required String key, required dynamic value}) async {
    return await _getAppBox().then((box) => box.put(key, value));
  }

  Future<dynamic> get(String key) async {
    return await _getAppBox().then((box) => box.get(key));
  }

  Future<void> remove(String key) async {
    return await _getAppBox().then((box) => box.delete(key));
  }
}
