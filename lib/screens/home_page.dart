import 'package:custom_tabbar/screens/custom_tabbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool close = false;
PageController pageController = PageController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          close != false ? const CustomTabbarWidget() : const Center(),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                Container(
                  color: Colors.yellow,
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tabbarButton(),
                            const TitleWidget(
                              title: " Title Page 1",
                            ),
                          ]),
                      BodyWidget(size: size),
                    ],
                  ),
                ),
                Container(
                  color: Colors.red,
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tabbarButton(),
                            const TitleWidget(
                              title: " Title Page 2",
                            ),
                          ]),
                      BodyWidget(size: size),
                    ],
                  ),
                ),
                Container(
                  color: Colors.greenAccent,
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tabbarButton(),
                            const TitleWidget(
                              title: " Title Page 3",
                            ),
                          ]),
                      BodyWidget(size: size),
                    ],
                  ),
                ),
              ],
            ),

            //RightWidget(),
          ),
        ],
      ),
    );
  }

  Row tabbarButton() {
    return Row(
      children: [
        close == false
            ? InkWell(
                onTap: () {
                  setState(() {
                    close = true;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(Icons.more_horiz, size: 28),
                ),
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    close = false;
                    print(!close);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(Icons.close, size: 28),
                ),
              ),
      ],
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Spacer(),
          Row(children: [
            const Spacer(),
            Container(
              height: size.height / 4,
              width: size.width / 3,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black, blurRadius: 12, spreadRadius: 0.5),
                  ]),
            ),
            const Spacer(),
            Container(
              height: size.height / 4,
              width: size.width / 3,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black, blurRadius: 12, spreadRadius: 0.5),
                  ]),
            ),
            const Spacer(),
          ]),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
                "It is a known fact that a duplicate page content distracts the reader. The purpose of using Lorem Ipsum is to increase readability by providing a more balanced distribution of letters",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.start),
          ),
          const Spacer(),
          Container(
              margin: EdgeInsets.all(10),
              height: size.height / 5,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black, blurRadius: 12, spreadRadius: 0.5),
                  ])),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
      ),
    );
  }
}
