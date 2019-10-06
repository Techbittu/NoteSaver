import 'package:flutter/material.dart';
import 'package:d_pad/utils/database_helper.dart';
import 'package:d_pad/model/note.dart';
import 'package:intl/intl.dart';

class Addnote extends StatefulWidget {

  final String appBarTitle;
  final Note note;
  Addnote(this.note,this.appBarTitle);

  @override
  _AddnoteState createState() => _AddnoteState(this.note,this.appBarTitle);
}

class _AddnoteState extends State<Addnote> {
  
  static var _priorities = ["High","Low"];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _AddnoteState(this.note,this.appBarTitle);
  
  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
        onWillPop: (){
          moveToLastScreen();
        },
        
        child:
      Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading:
            IconButton(icon: Icon(Icons.home),
            onPressed: (){
              moveToLastScreen();
            },
            )
        ),
      body: Padding(padding: EdgeInsets.only(
          top: 15.0,left: 10.0,right: 10.0,bottom: 10.0 ),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                  items: _priorities.map((String dropDownStringItem){
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                );
              }).toList(),
                  style: textStyle,
                  value: getPriorityAsString(note.priority),
                  onChanged: (valueSelectedByUser){
                setState(() {
                  debugPrint("User selected $valueSelectedByUser");
                  updatePriorityAsInt(valueSelectedByUser);
                });
                  }
                  ),
            ),

            Padding(padding: EdgeInsets.only(top: 5.0,bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value){
                  debugPrint("Something change $value");
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5.0,bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value){
                  debugPrint("Something change in text field $value");
                  updateDescription();
                },
                decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(child: RaisedButton(
                  onPressed: (){
                    setState(() {
                      debugPrint("Save button clicked");
                      _save();
                    });
                  },
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    "Save",
                    textScaleFactor: 1.5,
                  ),
                )),
                Container(width: 5.0,),
                Expanded(child: RaisedButton(
                  onPressed: (){
                    setState(() {
                      debugPrint("Delete button");
                      _delete();
                    });
                  },
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    "Delete",
                    textScaleFactor: 1.5,
                  ),
                ))
              ],
            ),
            )

          ],
        ),
      )
    ));
  }
  void moveToLastScreen(){
    Navigator.pop(context, true);
  }
  void updatePriorityAsInt(String value){
    switch (value){
      case "High":
        note.priority = 1;
        break;
      case "Low":
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value){
    String priority;
    switch (value){
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }
  void updateTitle(){
    note.title= titleController.text;
  }
  void updateDescription(){
    note.description = descriptionController.text;
  }
  void _save() async{

    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null){
      result = await helper.updateNote(note);
    }else{
      result = await helper.insertNote(note);
    }
    if (result != 0){
      _showAleartDialog("Status","Note Saved Sucessfully");
    }else{
      _showAleartDialog("Status","Something Error in Save");
    }
  }
  void _showAleartDialog(String title,String message){

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context,
    builder: (_) => alertDialog
    );
  }
  void _delete()async{

    moveToLastScreen();

    if (note.id == null){
      _showAleartDialog("Status", "No Note are deleted");
      return;
    }
   int result = await helper.deleteNote(note.id);
    if (result != 0){
      _showAleartDialog("Status", "Note Deleted Successfully");
    }else{
      _showAleartDialog("Status", "Error Occured while Deleting note");
    }
  }
}


