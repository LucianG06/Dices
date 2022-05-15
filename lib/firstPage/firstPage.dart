import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vibration/vibration.dart';
import 'package:zaruri/components/diceRoll.dart';
import 'package:zaruri/constants.dart';
import 'package:zaruri/history/emptyStateHistory.dart';
import 'package:zaruri/history/history.dart';
import 'package:zaruri/splash/splash.dart';
import 'package:zaruri/components/rounded_button.dart';
import 'package:shake/shake.dart';

final checkAnimation = ValueNotifier<bool>(true);
final rightDiceRollHistory = ValueNotifier<int>(-1);
final leftDiceRollHistory = ValueNotifier<int>(-1);

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int leftDiceRoll = 1;
  int rightDiceRoll = 1;
  DiceRoll? _diceRoll;
  final List<DiceRoll> _diceRolls = List.empty(growable: true);
  late ShakeDetector detector;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      dice();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  void dice() {
    setState(() {
      checkAnimation.value = false;
      _animationController.forward();
      Future.delayed(const Duration(milliseconds: 800), () {
        checkAnimation.value = true;
        leftDiceRoll = Random().nextInt(6) + 1;
        rightDiceRoll = Random().nextInt(6) + 1;

        _diceRoll =
            DiceRoll(leftDiceRoll: leftDiceRoll, rightDiceRoll: rightDiceRoll);
        _diceRoll!.calculateSum();
        _diceRolls.add(_diceRoll!);

        if (_diceRolls.length > 1) {
          leftDiceRollHistory.value =
              _diceRolls[_diceRolls.length - 2].leftDiceRoll;
          rightDiceRollHistory.value =
              _diceRolls[_diceRolls.length - 2].rightDiceRoll;
        }

        if (leftDiceRoll == rightDiceRoll) {
          Vibration.vibrate();
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        }
      });
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF332F2C),
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFF2E7C9), width: 2),
          borderRadius: BorderRadius.circular(20.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 32),
          Text(
            'Ai dat dublă!',
            style: GoogleFonts.titanOne(fontSize: 24, color: kPrimaryColor),
          ),
          const SizedBox(height: 16),
          Text(
            'Foarte tare! Bravo, mai\nîncearcă până mai dai o dată!',
            textAlign: TextAlign.center,
            style: GoogleFonts.titanOne(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 32),
          RoundedButton(
            text: "Super tare, mersi",
            press: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              right: 24,
              child: SizedBox(
                height: 48,
                width: 186,
                child: Material(
                  color: kPrimaryDarkColor,
                  borderRadius: BorderRadius.circular(24.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    splashColor: Colors.black26,
                    onTap: () {
                      if (_diceRolls.length > 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return History(diceRolls: _diceRolls);
                            },
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const EmptyStateHistory();
                            },
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: leftDiceRollHistory,
                            builder: (context, value, widget) {
                              return ValueListenableBuilder(
                                  valueListenable: leftDiceRollHistory,
                                  builder: (context, value, widget) {
                                    if (_diceRolls.length > 1) {
                                      return Text(
                                        'Zarul anterior \n                          ${leftDiceRollHistory.value}-${rightDiceRollHistory.value}',
                                        style: GoogleFonts.titanOne(
                                            fontSize: 16, color: Colors.white),
                                      );
                                    } else {
                                      return Text(
                                        'Zarul anterior \n                              ',
                                        style: GoogleFonts.titanOne(
                                            fontSize: 16, color: Colors.white),
                                      );
                                    }
                                  });
                            }),
                        Image.asset(
                          "assets/images/ic_nav_history.png",
                          width: 40,
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 286,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Lottie.asset(
                        'assets/animations/Dice_shuffle_01.json',
                        width: 108,
                        controller: _animationController,
                        repeat: true),
                  ),
                  const SizedBox(width: 40),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Lottie.asset(
                        'assets/animations/Dice_shuffle_02.json',
                        width: 108,
                        controller: _animationController,
                        repeat: true),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 104,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/illustration_app.png",
                  ),
                  const SizedBox(height: 52),
                  ValueListenableBuilder(
                    valueListenable: checkAnimation,
                    builder: (context, value, widget) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                  'assets/images/dice_face_0$leftDiceRoll.jpg',
                                  width: 108),
                            ),
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: checkAnimation.value,
                          ),
                          const SizedBox(width: 40),
                          Visibility(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                  'assets/images/dice_face_0$rightDiceRoll.jpg',
                                  width: 108),
                            ),
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: checkAnimation.value,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 84),
                  RoundedButton(
                    text: "Învârte zarurile",
                    press: () {
                      dice();
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '... sau dă shake ',
                        style: GoogleFonts.titanOne(
                            fontSize: 16, color: Colors.white),
                      ),
                      SvgPicture.asset(
                        "assets/icons/ic_shake.svg",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Image.asset(
                "assets/images/bg_footer.png",
                width: size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
