import 'dart:convert';

import 'package:api_demo/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class modeldemo extends StatefulWidget {
  const modeldemo({Key? key}) : super(key: key);

  @override
  State<modeldemo> createState() => _modeldemoState();
}

class _modeldemoState extends State<modeldemo> {
   List<Users> countries=[];
  @override
  void initState()
  {
    super.initState();
    getCountry().then((value) {
      setState(() {
        countries=value;
      });
    });
  }

   getCountry() async {
    var data;
    var response = await http.get(Uri.parse('https://gorest.co.in/public/v2/users'), headers: {
      "Accept": "application/json",
    });
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200)
      data = (responseBody as List)
          .map((i) => new Users.fromJson(i))
          .toList();
    return data;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
                leading: Icon(Icons.list),
                trailing: Text("GFG",
                  style: TextStyle(
                      color: Colors.green,fontSize: 15),),
                title:Text(countries[index].name)
            );
          }
      ),
    );
  }
}
