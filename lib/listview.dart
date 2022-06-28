import 'dart:convert';
import 'dart:io';
import 'package:api_demo/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  int totalPages=0;
  List<Users> passengers = [];
  final RefreshController refreshController = RefreshController(initialRefresh: true);


  Future<bool> getPassengerData({bool isRefresh = false}) async {
    var data;
    if (isRefresh) {
      currentPage = 1;
    }
    else
    {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }
    var response = await http.get(Uri.parse("https://gorest.co.in/public/v2/users"), headers:{"Accept":"application/json"});
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      data = (responseBody as List).map((i)=> Users.fromJson(i)).toList();

      if (isRefresh)
      {
        passengers = data as List<Users>;
        print(passengers);
      }else{
        passengers.addAll(data as List<Users>);
      }

      currentPage++;

      // totalPages = data;

      print(response.body);
      setState(() {});
      return true;
    }
    else {
      return false;
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getPassengerData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getPassengerData();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            final passenger = passengers[index];

            return ListTile(
              leading: passenger.status=="active"?Icon(Icons.verified_outlined,color: Colors.green,):Icon(Icons.block,color: Colors.red,),
              title: Text(passenger.name),
              subtitle: Text(passenger.email),
              trailing: Text(passenger.id.toString(),  style: TextStyle(color: Colors.grey),),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: passengers.length,
        ),
      ),
    );
  }
}