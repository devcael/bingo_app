import 'package:bingo_app/models/Chart.dart';
import 'package:bingo_app/models/Number.dart';
import 'package:bingo_app/models/Rules.dart';
import 'package:bingo_app/models/Tickets.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Ticket mainTicket = Ticket().addNumbers([
    Number(number: null, yPos: 0, xPos: 0),
    Number(number: 2, yPos: 0, xPos: 1),
    Number(number: 3, yPos: 0, xPos: 2),
    Number(number: 4, yPos: 0, xPos: 3),
    Number(number: 5, yPos: 0, xPos: 4),
    Number(number: 6, yPos: 0, xPos: 5),
    Number(number: 7, yPos: 0, xPos: 6),
    Number(number: 8, yPos: 0, xPos: 7),
    Number(number: 9, yPos: 0, xPos: 8),
    Number(number: 19, yPos: 2, xPos: 0),
    Number(number: 11, yPos: 2, xPos: 1),
    Number(number: 12, yPos: 2, xPos: 2),
    Number(number: 13, yPos: 2, xPos: 3),
    Number(number: 14, yPos: 2, xPos: 4),
    Number(number: 15, yPos: 2, xPos: 5),
    Number(number: 16, yPos: 2, xPos: 6),
    Number(number: 17, yPos: 2, xPos: 7),
    Number(number: 18, yPos: 2, xPos: 8),
    Number(number: 20, yPos: 1, xPos: 0),
    Number(number: 21, yPos: 1, xPos: 1),
    Number(number: 22, yPos: 1, xPos: 2),
    Number(number: 23, yPos: 1, xPos: 3),
    Number(number: 24, yPos: 1, xPos: 4),
    Number(number: 25, yPos: 1, xPos: 5),
    Number(number: 26, yPos: 1, xPos: 6),
    Number(number: 27, yPos: 1, xPos: 7),
    Number(number: 28, yPos: 1, xPos: 8),
  ]);
  setUpAll(() {
    mainTicket.restart();
  });

  group("Check Many Rules", () {
    test("Should check all numbers in all tickets", () {
      List<int> sortedNumbers = [1, 20, 19];
      mainTicket.checkNumberIfExists(1);
      mainTicket.checkNumberIfExists(20);
      mainTicket.checkNumberIfExists(19);

      Chart chart = Chart(id: 1);
      chart.addTicket(mainTicket);
      chart.addTicket(mainTicket);

      Rule verticalRule = AnyVerticalRule();

      expect(verticalRule.check(chart, sortedNumbers), equals(true));
    });

    test("Should check all numbers in all tickets", () {
      Rule allCheckedRule = AllCheckedRule();
      Chart chart = Chart(id: 1);
      chart.addTicket(mainTicket);
      mainTicket.forEachNumber((p0) {
        p0.checkNumber();
      });

      expect(allCheckedRule.check(chart, []), equals(true));
    });
  });
}
