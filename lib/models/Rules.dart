import 'package:bingo_app/models/Chart.dart';
import 'package:bingo_app/models/Number.dart';
import 'package:bingo_app/models/Tickets.dart';

abstract class Rule {
  bool check(Chart chart, List<int> sortedNumbers);
}

class AnyVerticalRule extends Rule {
  @override
  bool check(Chart chart, List<int> sortedNumbers) {
    bool wonSome = false;
    outloop:
    for (Ticket ticket in chart.tickets) {
      var xLen = ticket.xLen - 1;
      xPosLoop:
      for (var x = 0; x < xLen; x++) {
        for (var y = 0; y < ticket.yLen - 1; y++) {
          Number currNum = ticket.board[y][x];
          if (!currNum.isFree() && !currNum.wasSorted) {
            wonSome = false;
            continue xPosLoop;
          }
        }

        wonSome = true;
        break outloop;
      }
    }
    return wonSome;
  }
}

class AllCheckedRule extends Rule {
  @override
  bool check(Chart chart, List<int> sortedNumbers) {
    bool won = false;

    outLoop:
    for (Ticket ticket in chart.tickets) {
      for (var x = 0; x < ticket.xLen - 1; x++) {
        for (var y = 0; y < ticket.yLen - 1; y++) {
          Number currNum = ticket.board[y][x];
          if (!currNum.isFree() && !currNum.wasSorted) {
            won = false;
            break outLoop;
          }
        }
        won = true;
      }
    }

    return won;
  }
}
