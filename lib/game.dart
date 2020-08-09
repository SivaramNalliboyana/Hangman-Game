import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int status = 0;
  String word = wordslist[Random().nextInt(wordslist.length)];
  List guessedwords = [];
  List<String> images = [
    "images/hangman0.png",
    "images/hangman1.png",
    "images/hangman2.png",
    "images/hangman3.png",
    "images/hangman4.png",
    "images/hangman5.png",
    "images/hangman6.png",
  ];
  opendialog(String text) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 200,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          status = 0;
                          guessedwords.clear();
                          word = wordslist[Random().nextInt(wordslist.length)];
                        });
                      },
                      color: Colors.deepOrange,
                      child: Center(
                        child: Text(
                          "Play Again!",
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  handletext() {
    String displayword = '';
    for (int i = 0; i < word.length; i++) {
      var char = word[i];
      if (guessedwords.contains(char)) {
        displayword += char + " ";
      } else {
        displayword += "_ ";
      }
    }

    return displayword;
  }

  checkletter(String alphabet) {
    if (word.contains(alphabet)) {
      setState(() {
        guessedwords.add(alphabet);
      });
    } else {
      if (status != 6) {
        setState(() {
          status += 1;
        });
      } else {
        opendialog("YOU LOST, TRY AGAIN YOUR LUCK");
      }
    }

    bool isWoned = true;
    for (int i = 0; i < word.length; i++) {
      var char = word[i];
      if (!guessedwords.contains(char)) {
        setState(() {
          isWoned = false;
        });
        break;
      }
    }
    if (isWoned) {
      opendialog("HURRAY , YOU WON");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 30.0),
                alignment: Alignment.center,
                child: Text(
                  "Flutter Hangman",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700, fontSize: 25),
                  textAlign: TextAlign.center,
                )),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Image(
                image: AssetImage(images[status]),
                fit: BoxFit.cover,
              ),
            ),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  handletext(),
                  style: GoogleFonts.montserrat(fontSize: 30),
                  textAlign: TextAlign.center,
                )),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 8,
                children: letters.map((eachalpahbet) {
                  return GestureDetector(
                    onTap: () => checkletter(eachalpahbet),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: Center(
                        child: Text(
                          eachalpahbet,
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List wordslist = ['FLUTTER', 'PROGRAMMING', 'PYTHON', 'GOOGLE'];
List<String> letters = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];
