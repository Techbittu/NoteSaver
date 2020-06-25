import 'package:flutter/material.dart';
import 'package:d_pad/screen/notepad.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Note Saver",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.black)
      ),
      home: Mynewapp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
