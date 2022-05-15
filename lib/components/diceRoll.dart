
class DiceRoll {
  int leftDiceRoll = -1;
  int rightDiceRoll = -1;
  int sum = -1;

  DiceRoll({required this.leftDiceRoll, required this.rightDiceRoll});

  void calculateSum() {
    sum = leftDiceRoll + rightDiceRoll;
  }

  bool checkDouble() {
    if (rightDiceRoll == leftDiceRoll) {
      return true;
    }
    return false;
  }
}
