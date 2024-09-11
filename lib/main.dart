import 'package:flutter/material.dart';
import 'pages/queue_list_page.dart';
import 'pages/submit_queue_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queue System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => QueueListPage(),
        '/submit': (context) => SubmitQueuePage(),
      },
    );
  }
}
