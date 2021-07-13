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

  void ResetGame(){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
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
                  Text( "You Points: $points",
                    style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w500, 
                    ),
                  ),
                  SizedBox(height: 20, ),
                  Text( "Are you relly a Human?",
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500, 
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
                      ResetGame();
                    }, 
                    child: Text("Replay",
                        style: TextStyle(
                        fontSize: 34, fontWeight: FontWeight.w500,
                      ),
                    )),
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
                    onPressed: (){}, 
                    child: Text(" Menu ",
                        style: TextStyle(
                        fontSize: 34, fontWeight: FontWeight.w500,
                      ),
                    ))
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

              Future.delayed(const Duration(seconds: 3), (){
                setState(() {  
                  points = points + 100;
                  matches = matches + 1;
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
                  points = points - 50; 
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