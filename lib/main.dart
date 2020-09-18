import 'package:flutter/material.dart';
import 'Screens/SecondScreen.dart';
import 'package:move_picker/files_utils.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

Random random = new Random();

String Movie_URL = 'https://i.pinimg.com/originals/fe/9a/fb/fe9afbe8b357c2f0068b50626fb1e840.jpg';
String Path;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  load();
  runApp(
      MaterialApp(
    home: new MainScreen(),
  )
  );
}


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,

      body: SafeArea(
        child: Container(
          color: Colors.redAccent,
          child: Column(
            children: <Widget>[
              SizedBox(height: 8,),
              Row(
                children: <Widget>[
                  Text(' What To Watch', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: FlatButton(
                        onPressed: (){
                          HapticFeedback.mediumImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SecondScreen()),
                          );                        },
                        child: Icon(Icons.forward, size: 35,),

                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 550,
                    height: 550,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: new Offset(10, 10),
                        ),
                      ],
                      image: DecorationImage(
                        image: Path != null? FileImage(File(Path)) : NetworkImage(Movie_URL),
                        fit: BoxFit.cover,
                      ),
                    ),

                    child: FlatButton(

                      onPressed: (){
                        setState(() {
                          HapticFeedback.mediumImpact();
                          SystemSound.play(SystemSoundType.click);
                          Randomize();
                        });
                      },
                      splashColor: Colors.amber.withOpacity(.5),
                    ),

                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class RandomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top:17),
        child: Container(
          width: double.infinity,
          color: Colors.amber,
          child: FlatButton(onPressed: () {

          },
            child: Text('Randomize!!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white),),
          ),
        ),
      ),
    );
  }
}

void Randomize(){
  if(URL.length > 0){
    int index = random.nextInt(URL.length);
    if(URL.length == 0)
      Path = null;
    else
      Path = URL[index];
  }else
    {
      Movie_URL = 'https://i.pinimg.com/originals/60/e1/54/60e154fa402c0b097287df31773f0611.jpg';
    }

}

