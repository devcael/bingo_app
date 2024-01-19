import 'dart:math';

import 'package:bingo_app/models/Tickets.dart';

class BingoGame {
  int maxNumber;
  List<int> numbers = [];
  List<int> sortedNumbers = [];
  List<int> unsortedNumbers = [];
  List<Ticket> tickets = [];
  BingoGame({required this.tickets, this.maxNumber = 90}) {
    numbers = List<int>.generate(maxNumber, (index) => index + 1);
    unsortedNumbers = List<int>.generate(maxNumber, (index) => index + 1);
  }

  List<Ticket> get ticktes => tickets;

  void addSortedNumber(int number) {
    for (int sNumber in sortedNumbers) {
      if (sNumber == number) {
        throw Exception("You cannot add the same number twice");
      }
    }
    sortedNumbers.add(number);
    unsortedNumbers.remove(number);
  }

  void generateRandomSortedNumber() {
    int randomSortedNumber =
        unsortedNumbers[Random().nextInt(unsortedNumbers.length - 1)];
    addSortedNumber(randomSortedNumber);
  }
}
