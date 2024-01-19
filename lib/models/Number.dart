class Number {
  int xPos;
  int yPos;
  int? number;
  String? description;
  bool wasSorted;
  Number(
      {required this.number,
      this.wasSorted = false,
      this.description,
      required this.xPos,
      required this.yPos});

  bool isFree() {
    return number == null;
  }

  void checkNumber() {
    wasSorted = true;
  }

  void uncheckNumber() {
    wasSorted = false;
  }

  @override
  String toString() {
    return "[N:$number](X:$xPos,Y:$yPos)";
  }
}
