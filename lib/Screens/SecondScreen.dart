import 'package:flutter/material.dart';
import 'package:move_picker/files_utils.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:move_picker/main.dart';

List<Widget> moveList = List<Widget>();
AddURL(String url){
  URL.add(url);
  save();
}

List <Widget> Movieitems() {
  moveList.clear();
  for(int i = 0; i < URL.length; i++){
    moveList.add(MoveList(url: URL[i],index: i,));
  }
  moveList.add(AddMove());
  return moveList;

}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

void _showDialog(BuildContext context, int index) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Are you Sure You Want To Delete This!!!!"),
        //content: new Text("Alert Dialog body"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("No",style: TextStyle(fontSize: 30),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("Yes", style: TextStyle(fontSize: 30)),
            onPressed: () {
              URL.removeAt(index);
              save();
              Navigator.of(context).pop();
              //Rebuild(context);
            },
          ),
        ],
      );
    },
  );
}

void AddURL_Dialog(BuildContext context) {
  // flutter defined function

  final myController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Image Address"),
        //content: new Text("Alert Dialog body"),
        content: TextField(
          autocorrect: false,
          controller: myController,
          decoration: InputDecoration(
            labelText: 'URL',
            border: OutlineInputBorder(),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: new Text("ADD", style: TextStyle(fontSize: 30)),
            onPressed: () {
              AddURL(myController.text);
              Rebuild(context);
            },
          ),
          new FlatButton(
            child: new Text("CLOSE", style: TextStyle(fontSize: 30)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class _SecondScreenState extends State<SecondScreen> {

  bool test = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ClipOval(
                      child: Material(
                        color: Colors.red,
                        child: InkWell(
                          splashColor: Colors.pink, // inkwell color
                          child: SizedBox(width: 60, height: 60, child: Icon(Icons.keyboard_backspace, size: 50,)),
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainScreen()),
                            );
                            },
                        ),
                      ),
                    ),
                  ),
                  Text('Move List', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white),),

                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2, bottom: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue,
                    ),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverGrid(
                          delegate: SliverChildListDelegate.fixed(
                            Movieitems(),
                          ),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            childAspectRatio: 0.8,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoveList extends StatelessWidget {
  MoveList({this.url, this.index});
  String url;
  int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  offset: new Offset(3, 3.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  color: Color.fromRGBO(0, 0, 0, .7)
              )
            ],
            image: DecorationImage(
              image: FileImage(File(url)),
              fit: BoxFit.cover,
            )
        ),

        child: MaterialButton(
          onPressed: (){
            HapticFeedback.lightImpact();

          },
            onLongPress: (){
              HapticFeedback.heavyImpact();
              _showDialog(context, index);
            },
      ),
    ),
    );
  }
}

class AddMove extends StatelessWidget {

  Future _getImage(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    AddURL(image.path);
    Navigator.pop(context);
    Rebuild(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  offset: new Offset(3, 3.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  color: Color.fromRGBO(0, 0, 0, .7)
              )
            ],
          color: Colors.redAccent
        ),

        child: MaterialButton(
          onPressed: (){
            HapticFeedback.mediumImpact();
            _getImage(context);
          },
          child: Center(child: Icon(Icons.add,size: 100, color: Colors.white,)),
        ),
      ),
    );
  }
}

Rebuild(BuildContext context){
  Navigator.of(context).push(
  new MaterialPageRoute(
  builder: (BuildContext context){
    return new SecondScreen();
  }));
}

