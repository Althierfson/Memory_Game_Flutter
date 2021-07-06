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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pairs = getPairs();
    pairs.shuffle();

    visiblePairs = pairs;
    selected = true;

    Future.delayed(const Duration(seconds: 5), (){
      setState(() {
        visiblePairs = getHideSide();
        selected = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),
            points != 1000 ? Column(
              children: [
                Text("$points/1000", style:TextStyle(
                  fontSize: 24,
                    fontWeight: FontWeight.w500
                )),
                Text("Points"),
              ],
            ) : Container(),
            SizedBox(height: 20, ),
            points != 1000 ? GridView(
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
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(24)
              ),
              child: Text("Replay", style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),),
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

              Future.delayed(const Duration(seconds: 2), (){
                setState(() {  
                  points = points + 100;
                });
                selected = false;
                widget.parent.setState(() {
                });
              });
            }else{
              print("Wrong");

              selectedImageAssetPath = "";
              selected = true;

              Future.delayed(const Duration(seconds: 2), () {
                selected = false;
                setState(() {
                  //points = points - 50;
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