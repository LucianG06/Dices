import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaruri/components/diceRoll.dart';
import 'package:zaruri/history/historyItem.dart';

class History extends StatelessWidget {
  final List<DiceRoll> diceRolls;
  History({Key? key, required this.diceRolls}) : super(key: key);

  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 32,
              left: 20,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/ic_nav_back.png",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 50,
              ),
            ),
            Positioned(
              top: 52,
              left: 93,
              child: Text('Istoric',
                  style:
                      GoogleFonts.titanOne(fontSize: 24, color: Colors.white)),
            ),
            Positioned(
              top: 100,
              left: 32,
              right: 32,
              child: SingleChildScrollView(
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: diceRolls.length - 1,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: index == 0
                              ? const EdgeInsets.fromLTRB(8, 0, 8, 0)
                              : const EdgeInsets.only(left: 8),
                          child: HistoryItem(diceRoll: diceRolls[diceRolls.length - 2 - index]));
                    },
                  ),
              ),
              //child: HistoryItem(diceRoll: diceRoll),
            ),
          ],
        ),
      ),
    );
  }
}
