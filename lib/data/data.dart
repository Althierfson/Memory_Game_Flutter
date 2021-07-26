import 'package:memory_game/model/messege.dart';
import 'package:memory_game/model/tile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool menu = true;
int firstTime = 1;
int points = 0;
int record = 0;
int matches = 0;
bool selected = false;
String selectedImageAssetPath = "";
int selectedTileIndex = 123;

List<TileModel> pairs = [];
List<TileModel> visiblePairs = [];
List<Messege> menuMesseges = [];
List<Messege> endMesseges = [];

List<TileModel> getPairs() {

  List<TileModel> pairs = [];
  TileModel tileModel;

  //1
  tileModel = new TileModel("assets/N0.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //2
  tileModel = new TileModel("assets/N1.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //3
  tileModel = new TileModel("assets/N2.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //4
  tileModel = new TileModel("assets/N3.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //5
  tileModel = new TileModel("assets/N4.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //5
  tileModel = new TileModel("assets/N5.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //6
  tileModel = new TileModel("assets/N6.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //7
  tileModel = new TileModel("assets/N7.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //8
  tileModel = new TileModel("assets/N8.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //9
  tileModel = new TileModel("assets/N9.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  return pairs;
}

List<TileModel> getHideSide() {

  List<TileModel> pairs = [];
  TileModel tileModel;

  //1
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //2
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //3
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //4
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //5
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //5
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //6
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //7
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //8
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  //9
  tileModel = new TileModel("assets/hideSide.png", false);
  pairs.add(tileModel);
  pairs.add(tileModel);

  return pairs;
}

void saveRecord (int reco) async {
  final saveData = await SharedPreferences.getInstance();

  if(firstTime == 1) {
    saveData.setInt("Record", reco);
    saveData.setInt("firstTime", 0);
    return;
  }

  if(reco > record){
    saveData.setInt("Record", reco);
  }
}

Future<int> loadRecord() async {
  final saveData = await SharedPreferences.getInstance();

  int r = saveData.getInt("Record") ?? 0;
  firstTime = saveData.getInt("firstTime") ?? 1;
  
  return r;
}

List<Messege> getEndMesseges(){

  List<Messege> messeges = [];
  Messege messege;

  // #0 - Menssege
  messege = new Messege("ZzZzZzZzZz", 0, 0);
  messeges.add(messege);

  // #1 - Menssege
  messege = new Messege("Are you really a human?", 1000, 950);
  messeges.add(messege);

  // #2 - Menssege
  messege = new Messege("This is the worst points than I ever see.", 200, 0);
  messeges.add(messege);

  // #3 - Menssege
  messege = new Messege("Are you sure that you know how play this game?", 200, -100);
  messeges.add(messege);

  // #4 - Menssege
  messege = new Messege("You good! I not expected that.", 700, 600);
  messeges.add(messege);

  // #5 - Menssege
  messege = new Messege("In this game, you have to looking for the match! you know that right?", 100, -300);
  messeges.add(messege);

  // #6 - Menssege
  messege = new Messege("Finally!! A good point. I had already lost the hope!", 100, -300);
  messeges.add(messege);

  // #7 - Menssege
  messege = new Messege("Another bad points! Give up!! You not suffered enough?", 300, 0);
  messeges.add(messege);

  // #8 - Menssege
  messege = new Messege("Next time I will put a reCAPTCHA to make sure you not a Robot.", 1000, 950);
  messeges.add(messege);

  return messeges;
}

List<Messege> getMenuMesseges(){

  List<Messege> messeges = [];
  Messege messege;

  // #0 - Menssege
  messege = new Messege("ZzZzZzZzZz", 0, 0);
  messeges.add(messege);

  // #1 - Menssege
  messege = new Messege("Finally!! A good point. I had already lost the hope!", 600, 500);
  messeges.add(messege);

  // #2 - Menssege
  messege = new Messege("You again? Come on!", 300, 0);
  messeges.add(messege);

  // #3 - Menssege
  messege = new Messege("You know, this record is very cringe.", 300, -100);
  messeges.add(messege);

  // #4 - Menssege
  messege = new Messege("Oh my god!!! this is a record!", 1000, 800);
  messeges.add(messege);

  // #5 - Menssege
  messege = new Messege("I'm pride of you! This is a record.", 1000, 950);
  messeges.add(messege);

  // #6 - Menssege
  messege = new Messege("I think the you are not human.", 1000, 999);
  messeges.add(messege);

  return messeges;
}