import 'package:hive/hive.dart';

class HiveServices {
  Future<List<dynamic>> getData() async {
    var box = await Hive.openBox('userText');
    return box.values.toList();
  }

  addData(String text) async {
    var box = await Hive.openBox('userText');
    await box.add(text);
  }
}
