
/*
분 단위 통합 -> 시간으로 변경
 */

class ChangeAmountToTime{
  List<int> changeAmountToTime(int balance){
    int hours = (balance / 60).toInt();
    int minutes = (balance % 60).toInt();

    return [hours, minutes];
  }
}
