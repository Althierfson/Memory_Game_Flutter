import 'package:memory_game/main.dart';

class Messege {

  String messege;
  int maxPoints;
  int minPoints;

  Messege(this.messege, this.maxPoints, this.minPoints);

  void setMessege(String messege){
    this.messege = messege;
  }

  String getMessege(){
    return this.messege;
  }

  void setMaxPoints(int maxPoints){
    this.maxPoints = maxPoints;
  }

  int getMaxPoints(){
    return this.maxPoints;
  }

  void setMinPoints(int minPoints){
    this.minPoints = minPoints;
  }

  int getMinPoints(){
    return this.minPoints;
  }
  
}