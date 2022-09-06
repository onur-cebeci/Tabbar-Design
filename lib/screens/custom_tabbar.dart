import 'dart:math' as math;

import 'package:custom_tabbar/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomTabbarWidget extends StatefulWidget {
  const CustomTabbarWidget({Key? key}) : super(key: key);

  @override
  State<CustomTabbarWidget> createState() => _CustomTabbarWidgetState();
}

class _CustomTabbarWidgetState extends State<CustomTabbarWidget>
    with TickerProviderStateMixin {
  final List<String> _list = ["Page 1", "Page 2", "Page 3"];

  final List<GlobalKey> _keys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  int checkIndex = 0;
  Offset chackPositionOffset = const Offset(0, 0);
  Offset lastCheckOffset = const Offset(0, 0);

  Offset animationOffset = const Offset(0, 0);
  late Animation _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    checkIndex = _list.length - 3;
    super.initState();

    SchedulerBinding.instance!.endOfFrame.then((value) {
      calcuteCheckOffset();
      addAnimation();
    });
  }

  void addAnimation() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..addListener(() {
        setState(() {
          animationOffset = Offset(chackPositionOffset.dx, _animation.value);
        });
      });

    _animation = Tween(begin: lastCheckOffset.dy, end: chackPositionOffset.dy)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutBack));

    _animationController.forward();
  }

  void calcuteCheckOffset() {
    lastCheckOffset = chackPositionOffset;
    RenderBox? renderBox =
        _keys[checkIndex].currentContext?.findRenderObject() as RenderBox?;
    Offset? widgetOffset = renderBox?.localToGlobal(const Offset(0, 0));
    Size widgetSize = renderBox!.size;

    chackPositionOffset = Offset(widgetOffset!.dx + widgetSize.width,
        widgetOffset.dy + widgetSize.height / 4 * 3);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 70,
          decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(5))),
          child: Column(
            children: _buildList(),
          ),
        ),
        Positioned(
            top: animationOffset.dy,
            left: animationOffset.dx,
            child: CustomPaint(
              painter: CheckPointPainter(const Offset(15, 30)),
            ))
      ],
    );
  }

  List<Widget> _buildList() {
    List<Widget> _widget_list = [];

    _widget_list.add(const Padding(
      padding: EdgeInsets.only(top: 50),
      child: Icon(
        Icons.search,
        color: Colors.white,
        size: 30,
      ),
    ));

    for (int i = 0; i < _list.length; i++) {
      _widget_list.add(Expanded(
        child: GestureDetector(
            onTap: () {
              indexChecked(i);
            },
            child: VerticalText(_list[i], _keys[i], checkIndex == i)),
      ));
    }
    _widget_list.add(const Padding(
      padding: EdgeInsets.only(top: 50, bottom: 50),
    ));
    return _widget_list;
  }

  void indexChecked(int i) {
    pageController.jumpToPage(i);
    if (checkIndex == i) return;
    setState(() {
      checkIndex = i;
      calcuteCheckOffset();
      addAnimation();
    });
  }
}

class CheckPointPainter extends CustomPainter {
  double pointRadius = 5;
  double radius = 30;
  Offset offset;

  CheckPointPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    double startAngle = -math.pi / -2;
    double sweepAngle = -math.pi;

    paint.color = Colors.lightBlueAccent;

    paint.color = Colors.white;

    canvas.drawCircle(
        Offset(offset.dx - pointRadius / 2, offset.dy - pointRadius / 2),
        pointRadius,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class VerticalText extends StatelessWidget {
  String name;
  bool checked;
  GlobalKey globalKey;
  VerticalText(this.name, this.globalKey, this.checked, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      key: globalKey,
      quarterTurns: 3,
      child: Text(
        name,
        style: TextStyle(color: checked ? Colors.black : Colors.white),
      ),
    );
  }
}
