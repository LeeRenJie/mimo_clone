import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../exercise_page.dart';

class CustomCard extends StatefulWidget {
  final bool locked;
  final String svgPath;
  final String text;
  final double progress;

  const CustomCard({
    Key? key,
    required this.locked,
    required this.svgPath,
    required this.text,
    required this.progress,
  }) : super(key: key);

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: widget.locked ? Colors.grey[200] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: InkWell(
            onTap: () {
              if (!widget.locked) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExercisePage()),
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,20,0,10),
                    child: SvgPicture.asset(
                      widget.svgPath,
                      width: 20,
                      height: 20,
                      colorFilter: widget.locked ? const ColorFilter.mode(Color.fromARGB(100, 70, 70, 70), BlendMode.modulate) : null,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,15,0),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: widget.locked ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ),
                if (!widget.locked)
                  Padding(
                    padding: const EdgeInsets.only(left:9),
                    child: LinearProgressIndicator(
                      value: widget.progress,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 127, 84, 208)),
                    ),
                  ),
                if (widget.locked)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.lock_outline_rounded,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ]
    );
  }
}