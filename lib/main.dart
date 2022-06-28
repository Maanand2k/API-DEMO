import 'package:api_demo/paginatedtable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Widgets/tabbar.dart';
import 'datatable.dart';
import 'jsonparser.dart';
import 'listview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Data Table';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    home: MainPage(),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => TabBarWidget(
    title: 'Data Table',
    tabs: [
      Tab(icon: Icon(Icons.sort_by_alpha), text: 'Sortable'),
      Tab(icon: Icon(Icons.pageview_outlined), text: 'Pagination'),
      Tab(icon: Icon(Icons.list), text: 'Infinite Listview'),
      // Tab(icon:Icon(Icons.api), text:'Model Class')
    ],
    children: [
      EditablePage(),
      Pagination(),
      HomePage(),
      // modeldemo()
    ],
  );
}