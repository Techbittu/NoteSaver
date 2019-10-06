import 'package:flutter/material.dart';
import 'package:d_pad/screen/notepad.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "D_Note",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.deepPurple)
      ),
      home: Mynewapp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
