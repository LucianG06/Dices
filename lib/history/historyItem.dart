import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaruri/components/diceRoll.dart';
import 'package:zaruri/constants.dart';

class HistoryItem extends StatelessWidget {
  final DiceRoll diceRoll;
  const HistoryItem({
    Key? key,
    required this.diceRoll,
  }) : super(key: key);

  Widget getWidgetText(DiceRoll diceRoll) {
    if (diceRoll.checkDouble()) {
      return Text(
        '${diceRoll.sum}    ${diceRoll.leftDiceRoll}-${diceRoll.rightDiceRoll}                        Dublă ',
        style: GoogleFonts.titanOne(
            fontSize: 20, color: kPrimaryColor),
      );
    }
    return Text(
      '${diceRoll.sum}    ${diceRoll.leftDiceRoll}-${diceRoll.rightDiceRoll}',
      style: GoogleFonts.titanOne(
          fontSize: 20, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      width: 296,
      height: 40,
      decoration: BoxDecoration(
        color: kPrimaryDarkColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: getWidgetText(diceRoll),
    );
  }
}