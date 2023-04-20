import 'package:flutter/material.dart';
import 'dart:async';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:icon_decoration/icon_decoration.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  ExercisePageState createState() => ExercisePageState();
}

class ExercisePageState extends State<ExercisePage> {
  int _hearts = 5; // add hearts count
  int _timeLeft = 60; // add initial time left in seconds
  bool _timerRunning = false; // add timer running state

  @override
  void initState() {
    super.initState();
    _startTimer(); // start timer when page loads
  }

  // deduct a heart
  void _deductHeart() {
    if(mounted) {
      setState(() {
        if (_hearts > 0) {
          _hearts--;
        }
      });
    }
  }

  // start the timer
  void _startTimer() {
    if(mounted) {
      setState(() {
        _timerRunning = true;
      });
    }
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if(mounted) {
        setState(() {
          if (_timeLeft < 1) {
            timer.cancel();
            _timerRunning = false;
          } else {
            _timeLeft--;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.grey[500],
          icon: const Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Center(
          child: RowSuper(
            innerDistance: -15.0,
            children: [
              for (var i = 0; i < _hearts; i++)
                const DecoratedIcon(
                  icon: Icon(Icons.favorite_rounded, color: Colors.red),
                  decoration: IconDecoration(
                    border: IconBorder(
                      width: 3,
                      color: Colors.white,
                    )
                  ),
                )
            ],
          ),
        ),
        actions: [
          IconButton(
            color: Colors.grey[500],
            icon: const Icon(Icons.flag_outlined),
            onPressed: () {
              // add flag button action
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: _timerRunning ? (60 - _timeLeft) / 60 : 0,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 127, 84, 208)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16,16,16,10),
              // child: Instructions(
              //   text: 'Code a button that has the text Post.',
              //   codeWords: ['Post'],
              // ),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Code a button that has the text ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: "Post",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        backgroundColor: Color.fromARGB(255, 228, 226, 226),
                      ),
                    ),
                    TextSpan(
                      text: ".",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10,10,10,0),
                    child: Text(
                      'index.html',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  const Divider(),
                  Container(
                    //Code displayed here with empty spaces for user to fill in with button options
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Instructions extends StatelessWidget {
//   final String text;
//   final List<String> codeWords;

//   const Instructions({
//     Key? key,
//     required this.text,
//     required this.codeWords,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const TextStyle codeStyle = TextStyle(
//       color: Colors.black,
//       backgroundColor: Color.fromARGB(255, 228, 226, 226),
//     );

//     final List<TextSpan> children = <TextSpan>[];

//     // Split text into code and non-code segments and add them as TextSpans
//     final RegExp pattern = RegExp('(?<=\\s)|(?=\\s)|(?<=^)|(?=\$)|(${codeWords.map((word) => RegExp.escape(word)).join('|')})');
//     final List<String> segments = text.split(pattern);
//     for (int i = 0; i < segments.length; i++) {
//       if (codeWords.contains(segments[i])) {
//         children.add(TextSpan(text: segments[i], style: codeStyle));
//       } else {
//         // Split each non-code segment into words and highlight any that match a codeWord
//         final List<String> words = segments[i].split(' ');
//         final List<TextSpan> wordSpans = words.map((word) {
//           if (codeWords.contains(word)) {
//             return TextSpan(text: word, style: codeStyle);
//           } else {
//             return TextSpan(text: word);
//           }
//         }).toList();
//         if (i < segments.length - 1 && !codeWords.contains(segments[i + 1])) {
//           wordSpans.add(const TextSpan(text: ' '));
//         }
//         children.addAll(wordSpans);
//       }
//     }

//     return RichText(
//       text: TextSpan(
//         children: children,
//       ),
//     );
//   }
// }
