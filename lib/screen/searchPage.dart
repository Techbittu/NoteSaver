import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:d_pad/utils/database_helper.dart';
import 'package:d_pad/screen/notedetail.dart';
import "package:d_pad/model/note.dart";

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  TextEditingController searchTextEditingController = TextEditingController();

  emptyTheTextFormField(){
    searchTextEditingController.clear();
  }


  AppBar searchPageHeader(){
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        style: TextStyle(
          fontSize: 18.0, color: Colors.yellow,
        ),
        controller: searchTextEditingController,
        decoration: InputDecoration(
            hintText: "Search Here....",
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow,
              ),
            ),
            filled: true,
            prefixIcon: Icon(Icons.search, color: Colors.yellow, size: 30.0,),
            suffixIcon: IconButton(icon: Icon(Icons.clear, color:  Colors.yellow,), onPressed: emptyTheTextFormField,)
        ),
        onFieldSubmitted: null,
      ),
    );
  }

  Container displayNoSearchResultScreen(){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(Icons.search, color: Colors.yellow , size: 200.0,),
            Text("Search",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 65.0
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: searchPageHeader(),
      body: displayNoSearchResultScreen(),
    );
  }
}

class UserResult extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white54,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: ()=> {},
              child: Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
               /*       leading: CircleAvatar(
                        backgroundColor:
                        getPriorityColor(this.noteList[position].priority),
                        child: getPriorityIcon(this.noteList[position].priority),
                      ),
                      title: Text(this.noteList[position].title, style: titleStyle),
                      subtitle: Text(this.noteList[position].date),
                      onTap: () {
                        navigateToDetail((this.noteList[position]), "Edit Note");
                      })), */
            )
              )
            )
          ],
        ),
      ),
    );
  }
}