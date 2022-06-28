import 'package:flutter/material.dart';
import 'dart:math';


class Pagination extends StatelessWidget {
  Pagination({Key? key}) : super(key: key);

  final DataTableSource _data = MyData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    PaginatedDataTable(
            source: _data,
            header: const Text('Products'),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Price'))
            ],
            columnSpacing: 100,
            horizontalMargin: 50,
            rowsPerPage: 8,
            showCheckboxColumn: false,
          ));
  }
}

// The "soruce" of the table
class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data =
  List.generate(50, (index) => {
        "id": index,
        "title": "Item $index",
        "price": Random().nextInt(1000)
      });

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
    ]);
  }
}