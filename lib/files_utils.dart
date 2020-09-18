import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

List<String>URL = new List();
String textfile;

void save(){
  String file = '';
  for(int i = 0; i < URL.length; i++){
    if(i == 0)
      file = URL[i];
    else
      file = file + '\n' + URL[i];

  }
  print('Saving.....');

  FileUtils.saveToFile(file);
  load();
}

void remove(int index){
  URL.removeAt(index);
}

void load() async{
  LineSplitter ls = new LineSplitter();
  print('Loading.....');
  FileUtils.readFromFile().then((String value){
    //textfile = value.toString();
    URL = ls.convert(value.toString());

  });
}


class FileUtils{

  static Future<String> get getFilePath async{
    final destination = await getApplicationDocumentsDirectory();
    return destination.path;
  }

  static Future<File> get getFile async{
    final path = await getFilePath;
    return File('$path/myfile.txt');
  }
  static Future<File> saveToFile(String data) async {

    final file = await getFile;
    return file.writeAsString(data);

  }

  static Future<String> readFromFile() async {
    try{
      final file = await getFile;
      String fileContent = await file.readAsString();
      return fileContent;
    }catch(e){
      return "";
    }

  }
}