import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'widgets/custom_card.dart';

class LessonsPage extends StatefulWidget {
  const LessonsPage({Key? key}) : super(key: key);

  @override
  LessonsPageState createState() => LessonsPageState();
}

class LessonsPageState extends State<LessonsPage> {
  late List<CustomCard> smallCards;
  late List<CustomCard> bigCards;

  @override
  void initState() {
    super.initState();
    smallCards = [
      const CustomCard(
        locked: false,
        svgPath: "lib/images/html.svg",
        text: 'Discovering HTML and Tags',
        progress: 0.8,
      ),
      const CustomCard(
        locked: true,
        svgPath: "lib/images/html.svg",
        text: 'Structuring Text with Tags',
        progress: 0,
      ),
      const CustomCard(
        locked: true,
        svgPath: "lib/images/html.svg",
        text: 'Building Buttons',
        progress: 0,
      ),
      const CustomCard(
        locked: true,
        svgPath: "lib/images/html.svg",
        text: 'Creating Links',
        progress: 0,
      ),
      const CustomCard(
        locked: true,
        svgPath: "lib/images/html.svg",
        text: 'Adding Images',
        progress: 0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child:AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color.fromARGB(255, 52, 53, 99),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
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
                  width: 60,
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
                  width: 60,
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
              ]
            )
          ]
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 7, // 70% of the available space
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const  [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20,20,0,10),
                            child: Text(
                              'HTML Basics',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20,0,0,20),
                            child: Text(
                              'Create webpages using HTML tags',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3, // 30% of the available space
                    child: SizedBox(
                      height: 200,
                      child:CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width * 0.10, // 15% of screen width
                        lineWidth: MediaQuery.of(context).size.width * 0.02, // 2% of screen width
                        percent: 0.20,
                        center: Icon(
                          Icons.bolt,
                          size: 50.0 * MediaQuery.textScaleFactorOf(context),
                          color: const Color.fromARGB(255, 228, 230, 242),
                        ),
                        backgroundColor: const Color.fromARGB(255, 228, 230, 242),
                        progressColor: const Color.fromARGB(255, 127, 84, 208),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,5),
                    child: Row(
                      children: const[
                        Icon(
                          Icons.school_outlined,
                          color: Color.fromARGB(255, 88, 206, 92),
                          size: 35,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Learn',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 185 * (smallCards.length/2.ceil()+1),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20,20,20,0),
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.5,
                          crossAxisSpacing: 2.5,
                          childAspectRatio: 11/9, //width/height
                          children: smallCards,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
