import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
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
      Uri.parse('http://192.168.1.211:8000/send_message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'qrCode': await _scan(),
      }),
    );
  }
}
