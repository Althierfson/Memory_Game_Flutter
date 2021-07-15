import 'package:memory_game/model/tile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool menu = true;
int points = 0;
int record = 0;
int matches = 0;
bool selected = false;
String selectedImageAssetPath = "";
int selectedTileIndex = 123;

List<TileModel> pairs = [];
List<TileModel> visiblePairs = [];

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

  if(reco > record){
    saveData.setInt("Record", record);
  }
}

Future<int> loadRecord() async {
  final saveData = await SharedPreferences.getInstance();

  int record = saveData.getInt("Record") ?? 0;

  return record;
}