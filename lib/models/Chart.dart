import 'package:bingo_app/models/Tickets.dart';

class Chart {
  int id;
  int maxTickets;
  Chart({required this.id, this.maxTickets = 3});

  List<Ticket> tickets = [];

  void addTicket(Ticket ticket) {
    if (tickets.length >= maxTickets) {
      throw Exception("You cannot add more tickets");
    }
    tickets.add(ticket);
  }
}
