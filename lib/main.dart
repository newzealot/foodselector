import 'package:flutter/material.dart';
import 'package:foodselector/drink.dart';
import 'package:foodselector/food.dart';
import 'package:foodselector/statistics.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Selector',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Food Selector'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 150,
                minHeight: 75,
                maxWidth: 150,
                maxHeight: 75,
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  final storage = new FlutterSecureStorage();
                  Map<String, String> data = await storage.readAll();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Food(data),
                    ),
                  );
                },
                icon: const Icon(Icons.lunch_dining),
                label: const Text(
                  "Food",
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 150,
                minHeight: 75,
                maxWidth: 150,
                maxHeight: 75,
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  final storage = new FlutterSecureStorage();
                  Map<String, String> data = await storage.readAll();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Drink(data),
                    ),
                  );
                },
                icon: const Icon(Icons.local_cafe),
                label: const Text(
                  "Drink",
                ),
              ),
            ),
            // ConstrainedBox(
            //   constraints: const BoxConstraints(
            //     minHeight: 50,
            //   ),
            // ),
            // ConstrainedBox(
            //   constraints: const BoxConstraints(
            //     minWidth: 150,
            //     minHeight: 75,
            //     maxWidth: 150,
            //     maxHeight: 75,
            //   ),
            //   child: ElevatedButton.icon(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const Statistics(),
            //         ),
            //       );
            //     },
            //     icon: const Icon(Icons.settings),
            //     label: const Text(
            //       "Statistics",
            //     ),
            //   ),
            // ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 150,
                minHeight: 75,
                maxWidth: 150,
                maxHeight: 75,
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  final storage = new FlutterSecureStorage();
                  await storage.deleteAll();
                },
                icon: const Icon(Icons.restart_alt),
                label: const Text(
                  "Reset Cache",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
