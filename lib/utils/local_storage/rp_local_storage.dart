import 'package:get_storage/get_storage.dart';

class RpLocalStorage {
  static final RpLocalStorage _instance = RpLocalStorage._internal();

  final _storage = GetStorage();

  factory RpLocalStorage() {
    return _instance;
  }

  RpLocalStorage._internal();

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
