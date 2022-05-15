import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaruri/constants.dart';

class EmptyStateHistory extends StatefulWidget {
  const EmptyStateHistory({Key? key}) : super(key: key);

  @override
  _EmptyStateHistoryState createState() => _EmptyStateHistoryState();
}

class _EmptyStateHistoryState extends State<EmptyStateHistory> {
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
              top: 300,
              left: 104,
              child: Image.asset(
                "assets/images/illustration_empty_history.png",
                width: 152,
              ),
            ),
            Positioned(
              top: 300,
              left: 104,
              child: Image.asset(
                "assets/images/illustration_empty_history.png",
                width: 152,
              ),
            ),
            Positioned(
              top: 433,
              //left: 104,
              child: Text('Nu ai istoric încă',
                  style:
                      GoogleFonts.titanOne(fontSize: 24, color: kPrimaryColor)),
            ),
            Positioned(
              top: 472,
              //left: 104,
              child: Text(
                  'Dă shake sau învârte zarurile,\naici vor apărea toate scorurile tale',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.titanOne(
                      fontSize: 16, color: Colors.white, height: 1.5)),
            ),
          ],
        ),
      ),
    );
  }
}
