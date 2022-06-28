import 'dart:convert';
import 'package:api_demo/Model/model.dart';
import 'package:api_demo/Widgets/scrollable_widget.dart';
import 'package:api_demo/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgres/postgres.dart';


class EditablePage extends StatefulWidget {
  @override
  _EditablePageState createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {
  List<Users> users =[];
  int? sortColumnIndex;
  bool isAscending = false;

 getdistrict() async{
  var data;
  var response = await http.get(Uri.parse("https://gorest.co.in/public/v2/users"),
  headers:{"Accept":"application/json"});
  var responseBody = json.decode(response.body);
  print(responseBody);
  if(response.statusCode==200){
   data = (responseBody as List).map((i)=> Users.fromJson(i)).toList();
  }
  return data;
}

  Future operation() async {

    var connection = PostgreSQLConnection(
        "10.163.14.240", // hostURL
        5432,                                                                               // port
        "flutter_components",                                                         // databaseName
        username: "postgres",
        password: "postgres",
    );
    try{
      await connection.open();
      print("Connected");
    }
    catch(e){
      print("Error");
      print(e.toString());
    }

    List<List<dynamic>> results = await connection.query("SELECT contact_name, contact_email FROM contact_form WHERE contact_name = @aValue",
        substitutionValues: {"aValue" : "Anand"});

    for (final row in results)
    {
      var contact_name = row[0];
      var contact_email = row[1];
      print(contact_name);
      print(contact_email);
    }
  }



  @override
  void initState() {
    operation();
    super.initState();
    getdistrict().then((value){
    setState(() {
      users = value;
    });
  });
 }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          body: ScrollableWidget(child: buildDataTable(),
          ));

  Widget buildDataTable() {
    final columns = ['ID','Name', 'E-Mail'];
    return DataTable(
      columnSpacing: 80,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(users),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        onSort: onSort,
        label: Text(column),
      );
    }).toList();
  }

  List<DataRow> getRows
       (List<Users> users) => users.map((Users user) {
        final cells = [user.id,user.name,user.email];
        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(
              Text('$cell'),
            );
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
  cells.map ((data) =>DataCell(Text("$data"))).toList();

void onSort(int columnIndex, bool ascending) {
  if (columnIndex == 0) {
    users.sort((user1, user2) =>
        compareString(ascending, user1.id.toString(), user2.id.toString()));
  } else if (columnIndex == 1) {
    users.sort((user1, user2) =>
        compareString(ascending, user1.name, user2.name));

  }
  setState(() {
    this.sortColumnIndex = columnIndex;
    this.isAscending = ascending;
  });
}

int compareString(bool ascending,String value1,String value2)=>
 ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
