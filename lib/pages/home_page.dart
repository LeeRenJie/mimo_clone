
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'lessons_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  String dropdownvalue = 'Web';
  final items = ['Web', 'Python', 'SQL'];
  //Three Grey Dots
  Widget _buildGreyDotsRow(int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: Column(
        children: List.generate(count, (index) => Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 228, 230, 242),
            ),
          ),
        )),
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Center(
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 57, 60, 95),
            elevation: 0.0,
            title: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: IntrinsicWidth(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: const Color.fromARGB(255, 78, 83, 141)),
                    ),
                    child: DropdownButton(
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      isExpanded: true,
                      value: dropdownvalue,
                      style: const TextStyle(fontSize: 16),
                      dropdownColor: Colors.grey[800],
                      items: items.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white,),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if(mounted) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width:60,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 78, 83, 141),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.favorite, size: 25, color: Colors.red),
                        SizedBox(width: 2),
                        Text(
                          "5",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width:60,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 78, 83, 141),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.monetization_on_rounded, size: 25, color: Colors.yellow),
                        SizedBox(width: 2),
                        Text(
                          "200",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width:60,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 78, 83, 141),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.local_fire_department_rounded, size: 25, color: Colors.orange),
                        SizedBox(width: 2),
                        Text(
                          "8",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            //Flag pic
            AspectRatio(
              aspectRatio: 8 / 5, // replace with the aspect ratio of your SVG image
              child: SvgPicture.asset(
                'lib/images/flag.svg',
                fit: BoxFit.cover,
              ),
            ),
            // HTML Basics circle progress circle with lightning in middle
            Container(
              color: const Color.fromARGB(255, 249, 251, 255),
              child: Column(
                children:[
                  SizedBox(
                    height:  MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LessonsPage()),
                            );
                          },
                          child:CircularPercentIndicator(
                            radius: MediaQuery.of(context).size.width * 0.15, // 15% of screen width
                            lineWidth: MediaQuery.of(context).size.width * 0.02, // 2% of screen width
                            percent: 0.25,
                            center: Icon(
                              Icons.bolt,
                              size: 50.0 * MediaQuery.textScaleFactorOf(context),
                              color: const Color.fromARGB(255, 228, 230, 242),
                            ),
                            backgroundColor: const Color.fromARGB(255, 228, 230, 242),
                            progressColor: const Color.fromARGB(255, 127, 84, 208),
                            footer: Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                              child: const Text(
                                "HTML Basics",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                  fontFamily: "Helvetica"
                                )
                              )
                            )
                          ),
                        ),
                      )
                    )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGreyDotsRow(3),
                    ],
                  ),
                  // Locked Circles
                  SizedBox(
                    height:  MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child:CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width * 0.15, // 15% of screen width
                        lineWidth: MediaQuery.of(context).size.width * 0.15,
                        percent: 0,
                        center: const Icon(
                          Icons.lock_outline_rounded,
                          size: 50.0,
                          color: Color.fromARGB(255, 201, 201, 209),
                        ),
                        backgroundColor: const Color.fromARGB(255, 228, 230, 242),
                        footer: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                          child: const Text(
                            "CSS Basics",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              fontFamily: "Helvetica",
                              color: Color.fromARGB(255, 201, 201, 209)
                            )
                          )
                        )
                      ),
                    )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGreyDotsRow(3),
                    ],
                  ),
                  SizedBox(
                    height:  MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child:CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width * 0.15, // 15% of screen width
                        lineWidth: MediaQuery.of(context).size.width * 0.15,
                        percent: 0,
                        center: const Icon(
                          Icons.lock_outline_rounded,
                          size: 50.0,
                          color: Color.fromARGB(255, 201, 201, 209),
                        ),
                        backgroundColor: const Color.fromARGB(255, 228, 230, 242),
                        footer: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                          child: const Text(
                            "JavaScript Basics",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              fontFamily: "Helvetica",
                              color: Color.fromARGB(255, 201, 201, 209)
                            )
                          )
                        )
                      ),
                    )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGreyDotsRow(3),
                    ],
                  ),
                  SizedBox(
                    height:  MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child:CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width * 0.15, // 15% of screen width
                        lineWidth: MediaQuery.of(context).size.width * 0.15,
                        percent: 0,
                        center: const Icon(
                          Icons.lock_outline_rounded,
                          size: 50.0,
                          color: Color.fromARGB(255, 201, 201, 209),
                        ),
                        backgroundColor: const Color.fromARGB(255, 228, 230, 242),
                        footer: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                          child: const Text(
                            "HTML Intermediate",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              fontFamily: "Helvetica",
                              color: Color.fromARGB(255, 201, 201, 209)
                            )
                          )
                        )
                      ),
                    )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGreyDotsRow(3),
                    ],
                  ),
                  // Medal circle
                  SizedBox(
                    height:  MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      children: [
                        Center(
                          child:CircularPercentIndicator(
                            radius: MediaQuery.of(context).size.width * 0.20,
                            lineWidth: MediaQuery.of(context).size.width * 0.01,
                            percent: 0.01,
                            center: const Icon(
                              Icons.emoji_events_rounded,
                              size: 100.0,
                              color: Color.fromARGB(255, 201, 201, 209),
                            ),
                            backgroundColor: const Color.fromARGB(255, 228, 230, 242),
                            progressColor: const Color.fromARGB(255, 127, 84, 208),
                            circularStrokeCap: CircularStrokeCap.round,
                            footer: Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                              child: const Text(
                                "You're on the right track!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                  fontFamily: "Helvetica",
                                  color: Colors.black,
                                )
                              )
                            )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(50, MediaQuery.of(context).size.height * 0.01, 50, MediaQuery.of(context).size.height * 0.03),
                          child: Column(
                            children: [
                              const Text(
                                "Keep going and unlock your personalized certificate",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Helvetica",
                                  color: Color.fromARGB(255, 51, 9, 61),
                                )
                              ),
                              Padding(padding: const EdgeInsets.all(20),
                                child:ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 221, 212, 243),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'GET CERTIFICATE',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              )
            ),
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.book, color: Colors.black),
      ),
    );
  }
}
