
/*
송금할때 사용 : "분"단위로 바꿔줌
 */

class ChangeTimeToAmount{
  int changeTimeToAmount(int hours, int minutes){
    int amount = (hours * 60) + minutes;
    return amount;
  }
}
