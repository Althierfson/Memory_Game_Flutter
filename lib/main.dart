import 'package:flutter/material.dart';
import 'package:memory_game/data/data.dart';
import 'package:memory_game/model/tile_model.dart';
// video base: https://www.youtube.com/watch?v=vfF0-hZaKNM

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue.shade50
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String menuMsg = "";
  String endMsg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDatas();
  }

  void readDatas() async {
    record = await loadRecord();
    takeMenuMessege();
  }

  void resetGame(){
    print("Game Reseted");

    setState(() {
      points = 0;
      matches = 0;

      pairs = getPairs();
      pairs.shuffle();

      visiblePairs = pairs;
      selected = true;
    });

    Future.delayed(const Duration(seconds: 4), (){
      setState(() {
        visiblePairs = getHideSide();
        selected = false;
      });
    });
  }

  void takeMenuMessege(){
    setState(() {
      int i=0;
      String msg, key;

      menuMesseges = getMenuMesseges();
      
      if(record == 0){
        menuMsg = menuMesseges[0].getMessege();
        return;
      }

      msg = menuMesseges[0].getMessege();
      key = menuMesseges[0].getMessege();

      menuMesseges.shuffle();

      while(msg == key && i != menuMesseges.length-1){
        if(record <= menuMesseges[i].getMaxPoints() && record >= menuMesseges[i].getMinPoints() && menuMesseges[i].getMessege() != key){
          msg = menuMesseges[i].getMessege();
          menuMsg =  msg;
          return;
        }

        i++;
      }
      menuMsg = msg;
    });
  }

  String takeEndMessege(){
    int i=0;
    String msg, key;

    endMesseges = getEndMesseges();

    if(points == 0){
      return endMesseges[0].getMessege();
    }

    msg = endMesseges[0].getMessege();
    key = endMesseges[0].getMessege();

    endMesseges.shuffle();

    while(msg == key && i != endMesseges.length-1){
      if(points <= endMesseges[i].getMaxPoints() && points >= endMesseges[i].getMinPoints() && endMesseges[i].getMessege() != key){
        msg = endMesseges[i].getMessege();
        return msg;
      }

      i++;
    }
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: menu == true ? Center(
          child: Column(
          children: [
            SizedBox(height: 25),
            Text("Memory Game",
                style: TextStyle(
                fontSize: 34, fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 25),
            Text("Record: $record",
                style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 25),
            Text(menuMsg,
                style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side:BorderSide(color: Colors.black),
                  )
                ),
              ),
              onPressed: (){
                menu = false;
                resetGame();
              }, 
              child: Text("New Game",
                  style: TextStyle(
                  fontSize: 34, fontWeight: FontWeight.w500,
                ),
              ))
          ],
        )) : Column(
          children: <Widget>[
            SizedBox(height: 25),
            matches != 10 ? Column(
              children: [
                Text("$points/1000", style:TextStyle(
                  fontSize: 24,
                    fontWeight: FontWeight.w500
                )),
                Text("Points"),
              ],
            ) : Container(),
            SizedBox(height: 20, ),
            matches != 10 ? GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 0.0, maxCrossAxisExtent: 100
              ),
              children: List.generate(visiblePairs.length, (index){
                return Tile(
                  imageAssetPath: visiblePairs[index].getImageAssetPath(),
                  tileIndex: index,
                  parent: this,
                );
              }),
            ) : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text( "End Game",
                    style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w500, 
                    ),
                  ),
                  SizedBox(height: 20, ),
                  Text( "You Points: $points",
                    style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w500, 
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20, ),
                  Text( takeEndMessege(),
                    style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20, ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side:BorderSide(color: Colors.black),
                        )
                      ),
                    ),
                    onPressed: (){
                      resetGame();
                    }, 
                    child: Text("Replay",
                        style: TextStyle(
                        fontSize: 34, fontWeight: FontWeight.w500,
                      ),
                    )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {

  String imageAssetPath;
  int tileIndex;
  _HomePageState parent;
  Tile({required this.imageAssetPath, required this.parent, required this.tileIndex});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(!selected){
          if(selectedImageAssetPath != ""){

            if(selectedImageAssetPath == pairs[widget.tileIndex].getImageAssetPath()) {
              print("Correct");

              selectedImageAssetPath = "";
              selected = true;

              Future.delayed(const Duration(seconds: 1), (){
                setState(() {  
                  points = points + 100;
                  matches = matches + 1;
                  if(matches == 10){
                    print("object save");
                    saveRecord(points);
                  }
                });
                selected = false;
                widget.parent.setState(() {
                });
              });
            }else{
              print("Wrong");

              selectedImageAssetPath = "";
              selected = true;

              Future.delayed(const Duration(seconds: 1), () {
                selected = false;
                setState(() {
                  points = points - 75;
                });
                widget.parent.setState(() {
                  pairs[widget.tileIndex].setIsSelected(false);
                  pairs[selectedTileIndex].setIsSelected(false);
                });
              });
            }

          }else{
            selectedTileIndex = widget.tileIndex;
            selectedImageAssetPath = pairs[widget.tileIndex].getImageAssetPath();
          }

          setState(() {
            pairs[widget.tileIndex].setIsSelected(true);
          });
          print("Virar carta");
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Image.asset(pairs[widget.tileIndex].getIsSelected() ? pairs[widget.tileIndex].getImageAssetPath() : widget.imageAssetPath)
      ),
    );
  }
}