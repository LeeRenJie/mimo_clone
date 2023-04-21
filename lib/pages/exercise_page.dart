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
    // set the _timerRunning flag to true to indicate that the timer is running
    if (mounted) {
      setState(() {
        _timerRunning = true;
      });
    }

    // set the timer interval to one second
    const oneSec = Duration(seconds: 1);

    // start the timer and execute the callback function every one second
    Timer.periodic(oneSec, (timer) {
      // check if the widget is still mounted before updating its state
      if (mounted) {
        setState(() {
          // decrement the remaining time by one second
          if (_timeLeft < 1) {
            // if the timer has expired, cancel the timer and set _timerRunning to false
            timer.cancel();
            _timerRunning = false;
          } else {
            _timeLeft--;
          }
        });
      }
    });
  }

  List<ElevatedButton> answerButtonRow(List<String> buttonTextList) {
    return buttonTextList.map((text) {
      return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
        child: Text(text, style: const TextStyle(color: Colors.black)),
      );
    }).toList();
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16,16,16,10),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,10,10,0),
                        child: Text(
                          'index.html',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,0),
                        child:TextField(
                          decoration: InputDecoration(
                            hintText: 'Answer here...',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              letterSpacing: 1.0,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 1.0,
                          ),
                          cursorColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  color:Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.refresh_outlined),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.backspace_outlined),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255,78, 83, 141)),
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                              ),
                              child: const Icon(Icons.play_arrow),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          childAspectRatio: 5/3,
                          mainAxisSpacing:8,
                          crossAxisSpacing: 8,
                          children: answerButtonRow(['>', '</', 'button', 'button', '>', '<', 'Post']),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
