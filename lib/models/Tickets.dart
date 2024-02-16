// ignore_for_file: non_constant_identifier_names

import 'package:bingo_app/exceptions/AlreadyExistsNumber.dart';
import 'package:bingo_app/models/Number.dart';

typedef TicketBoard = List<List<Number>>;

class Ticket {
  int xLen;
  int yLen;
  TicketBoard board = [];
  Ticket({this.xLen = 9, this.yLen = 3}) {
    board = drawTicket();
  }

  Ticket addNumbers(List<Number> numbers) {
    for (var number in numbers) {
      addNumber(number);
    }
    return this;
  }

  Number? getNumber(int number) {
    Number? numberFound;
    forEachNumber((p0) {
      if (p0.number == number) {
        numberFound = p0;
      }
    });
    return numberFound;
  }

  bool checkNumberIfExists(int number) {
    bool hasNumber = false;
    forEachNumber((p0) {
      if (p0.number == number) {
        p0.checkNumber();
        hasNumber = true;
      }
    });
    return hasNumber;
  }

  TicketBoard drawTicket() {
    TicketBoard ticket = [];

    for (var y = 0; y < yLen; y++) {
      List<Number> row = [];
      for (var x = 0; x < xLen; x++) {
        row.add(Number(
            number: null,
            wasSorted: false,
            xPos: x,
            yPos: y,
            description: null));
      }
      ticket.add(row);
    }
    return ticket;
  }

  void restart() {
    forEachNumber((p0) {
      p0.uncheckNumber();
    });
  }

  void forEachNumber(void Function(Number) f) {
    for (var row in board) {
      for (var number in row) {
        if (!number.isFree()) {
          f(number);
        }
      }
    }
  }

  void addNumber(Number number) {
    forEachNumber((p0) {
      if (p0.number == number.number) {
        throw AlreadyExistsNumber("Number already exists in ticket");
      }
    });
    board[number.yPos][number.xPos] = number;
  }

  @override
  String toString() {
    String ticket = "";
    for (var row in board) {
      for (var number in row) {
        ticket += "$number ";
      }
      ticket += "\n";
    }
    return ticket;
  }
}

extension CheckListTickets on List<Ticket> {
  int checkNumberInAllTickets(int number) {
    int ticketsAmount = 0;
    for (var ticket in this) {
      if (ticket.checkNumberIfExists(number)) {
        ticketsAmount++;
      }
    }
    return ticketsAmount;
  }

  int restartTickets() {
    int ticketsAmount = 0;
    for (var ticket in this) {
      ticket.restart();
    }
    return ticketsAmount;
  }
}
