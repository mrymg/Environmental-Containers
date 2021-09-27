import 'package:connectivity/connectivity.dart';
import 'package:evrka_case/views/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:evrka_case/customWidgets/custColors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evreka Containers',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const getConnectionInfo(),
    );
  }
}

class getConnectionInfo extends StatefulWidget {
  const getConnectionInfo({Key? key}) : super(key: key);

  @override
  _getConnectionInfoState createState() => _getConnectionInfoState();
}

class _getConnectionInfoState extends State<getConnectionInfo> {
  bool isConnected = true;
  @override
  Widget build(BuildContext context) {
    connectionChecker();
    if (isConnected == false) {
      return const Center(
          child: Scaffold(
        body: Center(child: Text("Please check your interner connection.")),
      ));
    } else {
      return Login();
    }
  }

  void connectionChecker() async {
    var connectivity = await Connectivity().checkConnectivity();
    print(connectivity);
    if (connectivity == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    } else {
      setState(() {
        isConnected = true;
      });
    }
  }
}
