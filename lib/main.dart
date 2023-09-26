import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'flutter_web_auth_2_example.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late String _userId = '';
  late String _email = '';
  late String _expiresIn = '';

  _MyHomePageState();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _logIn() async {

    FlutterWebAuth2Example flutterWebAuth2Example= FlutterWebAuth2Example();

    final response = await flutterWebAuth2Example.LogIn();
    final accessToken = jsonDecode(response)['access_token'] as String;

    Map<String, dynamic> payload = Jwt.parseJwt(accessToken);

    setState(() {
      _userId = payload['sub'];
      _email = payload['email'];
      _expiresIn = payload['exp'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(10),
                    child: Column(children: <Widget>[
                  const Text(
                    'OAUTH 2.0 Code Flow using Flutter web auth 2',
                  ),
                  TextButton(
                      child: const Text('Log In'), onPressed: () => _logIn()),
                ]))
              ],
            ),
            Container(
                margin: EdgeInsets.all(10),
                child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$_userId',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '$_email',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '$_expiresIn',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _logIn,
        tooltip: 'Reset',
        child: const Icon(Icons.add),
      ),
    );
  }
}
