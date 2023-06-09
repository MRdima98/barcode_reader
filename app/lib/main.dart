import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
          home: Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () {
                createAlbum();
                },
                child: Text('Leggi codice'),
                ),
              )
            )
          );
    }

  Future<String> _scan() async {
    await Permission.camera.request();
    return (await scanner.scan()).toString();
  }

  Future<http.Response> createAlbum() async {
    return http.post(
      Uri.https('dev.dumitru.fr:80', 'send_message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'qrCode': await _scan(),
      }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
