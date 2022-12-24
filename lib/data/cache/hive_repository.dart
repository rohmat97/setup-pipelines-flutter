import 'package:hive_flutter/hive_flutter.dart';

abstract class IRepository<T> {
  Future<T> get(String id);
  Future<void> add(T object);
  Future<void> put(String id, T object);
}

abstract class KaiObject {
  String getId();
}

abstract class HiveRepository<T> implements IRepository<KaiObject> {
  Box? _box;

  HiveRepository() {
    Hive.openBox<void>(T.toString()).then(
            (value) => _box = value);
  }

  KaiObject deserialize(String json);
  String serialize(T t);

  @override
  Future<KaiObject> get(String id) async {
    var json = _box?.get(id);
    return deserialize(json);
  }

  @override
  Future<void> put(String id, KaiObject obj) async {
    await _box?.put(id, serialize(obj as T));
  }

  @override
  Future<void> add(KaiObject object) async {
    if (boxIsClosed) {
      return;
    }

    await _box?.put(object.getId(), serialize(object as T));
  }

  bool get boxIsClosed => !(_box?.isOpen ?? false);
}
