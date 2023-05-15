import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

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
  void getNext() async {
    cameraScanResult = (await scanner.scan()).toString();
    notifyListeners();
  }

  Future<bool> requestFilePermission() async {
    PermissionStatus result;
    result = await Permission.camera.request();
    if (result.isGranted){
      return true;
    }
    return false;
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
                  appState.requestFilePermission().then((value) {
                    if(value){
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
