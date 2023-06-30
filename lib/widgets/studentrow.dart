import 'package:flutter/material.dart';

class DataTableGenerator {
  static List<DataRow> generateRows(List<MyData> dataList) {
    List<DataRow> rows = [];
    for (var data in dataList) {
      DataRow row = DataRow(
        cells: [
          DataCell(Text(data.regno)),
          DataCell(Text(data.name)),
          DataCell(Text(data.clss)),
          DataCell(Text(data.section)),
          DataCell(ElevatedButton(
            onPressed: () {},
            child: Text('view profile'),
          )),
           DataCell(ElevatedButton(
            onPressed: () {},
            child: Text('view virtal ID'),
          )),
           DataCell(ElevatedButton(
            onPressed: () {},
            child: Text('delate'),
          )),
        ],
      );

      rows.add(row);
    }
    return rows;
  }
}
