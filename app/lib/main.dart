import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String cameraScanResult = "default";
  String tmp = "stuff";

  void getNext() async {
    // tmp = (await scanner.scan()).toString();
    cameraScanResult = (await createAlbum('stuff')).body;
    notifyListeners();
  }

  Future<bool> requestFilePermission() async {
    PermissionStatus result;
    result = await Permission.camera.request();
    // var result2 = await Permission.internet.request();
    if (result.isGranted) {
      return true;
    }
    return false;
  }

  Future<http.Response> createAlbum(String title) {
    return http.get(
      Uri.parse('http://localhost:8000'),
      // Uri.parse('http://192.168.1.254:8000'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: jsonEncode(<String, String>{
      //   'title': title,
      // }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('lol'),
            Text(appState.cameraScanResult),
            ElevatedButton(
              onPressed: () {
                appState.createAlbum("My album baby");
                appState.requestFilePermission().then((value) {
                  if (value) {
                    appState.getNext();
                  }
                });
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
