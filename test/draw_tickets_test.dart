import 'package:bingo_app/models/Chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bingo_app/models/Number.dart';
import 'package:bingo_app/models/Tickets.dart';

void main() {
  group('Ticket', () {
    test('drawTicket should return a 2D list of Number', () {
      Ticket ticket = Ticket();

      List<List<Number>> board = ticket.drawTicket();

      expect(board, isA<List<List<Number>>>());
      expect(board.length, isNonZero);
      for (var row in board) {
        expect(row, isA<List<Number>>());
        expect(row.length, isNonZero);
      }
    });

    test("drawTicket should return a 3x10 2D list of number", () {
      Ticket ticket = Ticket(xLen: 10);
      List<List<Number>> board = ticket.drawTicket();
      expect(board.length, equals(3));
      for (var row in board) {
        expect(row.length, equals(10));
      }
    });

    test("Should add a new number to x0 and y0 pos", () {
      Ticket ticket = Ticket();
      Number number = Number(number: 1, xPos: 0, yPos: 0);
      ticket.addNumber(number);
      expect(ticket.board[0][0].number, equals(1));
    });

    test("Should't add a new number to x0 and y0 pos", () {
      Ticket ticket = Ticket();
      Number number = Number(number: 1, xPos: 0, yPos: 0);

      Number number2 = Number(number: 1, xPos: 0, yPos: 1);
      ticket.addNumber(number);
      expect(() => ticket.addNumber(number2), throwsException);
    });

    test("Should check a number on ticket", () {
      Ticket ticket = Ticket();
      Number number = Number(number: 1, xPos: 0, yPos: 0);
      ticket.addNumber(number);
      ticket.checkNumberIfExists(1);
      expect(ticket.board[0][0].wasSorted, equals(true));
    });

    test("Should check all added numbers on ticket", () {
      Ticket ticket = Ticket();
      Number number = Number(number: 1, xPos: 0, yPos: 0);
      Number number2 = Number(number: 2, xPos: 1, yPos: 0);
      Number number3 = Number(number: 3, xPos: 2, yPos: 0);
      ticket.addNumber(number);
      ticket.addNumber(number2);
      ticket.addNumber(number3);
      ticket.checkNumberIfExists(1);
      ticket.checkNumberIfExists(2);
      ticket.checkNumberIfExists(3);
      ticket.forEachNumber((p0) {
        expect(p0.wasSorted, equals(true));
      });
    });

    test("Should uncheck all added numbers on ticket", () {
      Ticket ticket = Ticket();
      Number number = Number(number: 1, xPos: 0, yPos: 0);
      Number number2 = Number(number: 2, xPos: 1, yPos: 0);
      Number number3 = Number(number: 3, xPos: 2, yPos: 0);
      ticket.addNumber(number);
      ticket.addNumber(number2);
      ticket.addNumber(number3);
      ticket.checkNumberIfExists(1);
      ticket.checkNumberIfExists(2);
      ticket.checkNumberIfExists(3);
      ticket.forEachNumber((p0) {
        expect(p0.wasSorted, equals(true));
      });
      ticket.restart();
      ticket.forEachNumber((p0) {
        expect(p0.wasSorted, equals(false));
      });
    });

    test("Should create a new char and check all numbers in all tickets", () {
      Chart chart = Chart(
        id: 1,
        maxTickets: 3,
      );

      Ticket ticket = Ticket().addNumbers([
        Number(number: 1, xPos: 0, yPos: 0),
        Number(number: 2, xPos: 1, yPos: 0),
        Number(number: 3, xPos: 2, yPos: 0),
      ]);

      chart.addTicket(ticket);
      chart.addTicket(ticket);
      chart.addTicket(ticket);

      chart.tickets.checkNumberInAllTickets(1);

      for (var ticket in chart.tickets) {
        Number? number = ticket.getNumber(1);
        expect(number, isNotNull);
        expect(number?.wasSorted, equals(true));
      }
    });
  });
}
