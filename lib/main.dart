import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomeApp(),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({super.key});

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  List myPhotosList = [];
  bool isLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    getPhotosApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !isLoaded
            ? const CircularProgressIndicator()
            : getLIstBuilder(context),
      ),
    );
  }

  ListView getLIstBuilder(context) {
    var List = ListView.builder(
        itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(myPhotosList[index]['title']),
              leading: Image.network(myPhotosList[index]['thumbnailUrl']),
              subtitle: Text(myPhotosList[index]['id'].toString()),
            ));
    return List;
  }

  getPhotosApi() async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'photos');
    var result = await http.get(url);
    print(result.body);
    setState(() {
      myPhotosList = jsonDecode(result.body);
      isLoaded = true;
    });
  }
}
