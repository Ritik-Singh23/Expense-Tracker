import 'package:hive/hive.dart';

class DbHelper {
  late Box moneybox;

  DbHelper() {
    openBox();
  }

  openBox() {
    moneybox = Hive.box('MoneyDB');
  }

  void addData(int amount, DateTime date, String type, String note) async {
    var value = {'amount': amount, 'date': date, 'type': type, 'note': note};
    moneybox.add(value);
  }

  Future deleteData(
    int index,
  ) async {
    await moneybox.deleteAt(index);
  }

  Future cleanData() async {
    await moneybox.clear();
  }

  Future<Map> fetch() {
    if (moneybox.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(moneybox.toMap());
    }
  }
}
