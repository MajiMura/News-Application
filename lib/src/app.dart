import 'package:flutter/material.dart';

import 'screens/news_list.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News",
      home: NewsList(),
    );
  }
}

