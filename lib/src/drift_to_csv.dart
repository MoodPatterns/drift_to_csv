import 'dart:io';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';


class DriftToCsv {

  static Future<File?> queryToCsv(List<DataClass> query, String path) async {
    if(query.isEmpty) return null;

    final keys = query.first.toJson().keys.toList(growable: false);

    List<List<dynamic>> rows = [];

    rows.add(keys);

    for (var element in query) {
      rows.add(element.toJson().values.toList(growable: false));
    }

    final csv = const ListToCsvConverter().convert(rows);

    final file = File(path);
    if (await file.exists()) await file.delete();

    await file.writeAsString(csv);

    return file;
  }

}
