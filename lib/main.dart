import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class AppColors {
  static final Color whiteshPurple = Color.fromRGBO(158, 171, 252, 1);
  static final Color lightPurple = Color.fromRGBO(147, 112, 232, 1);
  static final Color purple = Color.fromRGBO(108, 87, 229, 1);
  static final Color darkPurple = Color.fromRGBO(96, 77, 203, 1);
  static final Color blue = Color.fromRGBO(110, 176, 218, 1);
  static final Color lightBlue = Color.fromRGBO(137, 210, 251, 1);
  static final Color pink = Color.fromRGBO(250, 187, 206, 1);
  static final Color lightPink = Color.fromRGBO(248, 221, 200, 1);
  static final Color yellow = Color.fromRGBO(249, 203, 70, 1);
  static final Color teal = Color.fromRGBO(90, 191, 162, 1);
  static final Color grey = Color.fromRGBO(135, 135, 135, 1);
  static final Color lightGrey = Color.fromRGBO(230, 230, 230, 1);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.purple),
        ),
        drawer: Drawer(),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidgetState();
  }
}

class MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  Tween tween = Tween(begin: 0.0, end: 5.0);
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _animation = tween.animate(_animationController);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, snapshot) {
          return CustomPaint(
            painter: MyPainter(offset: _animation.value),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                'SUED',
                                style: TextStyle(
                                    color: AppColors.darkPurple,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2),
                              ),
                            ),
                            Container(
                              width: 130,
                              height: 24,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 4, bottom: 4, right: 36),
                                child: Text(
                                  'victorsued',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.grey),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.lightGrey,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(20))),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              gradient: LinearGradient(
                                  colors: [
                                    AppColors.lightBlue,
                                    AppColors.purple
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight)),
                          child: Padding(
                              padding: EdgeInsets.all(36),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Current Balance',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.darkPurple),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'BTC ',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white),
                                          ),
                                          Text('22.00',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                  color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('USD ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                          Text('224633.75',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.account_balance_wallet,
                                      color: AppColors.darkPurple)
                                ],
                              )),
                        )),
                  ],
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  children: [
                    customCard(Icons.arrow_upward, 'SEND', AppColors.yellow),
                    customCard(Icons.arrow_downward, 'RECEIVE', AppColors.pink),
                    customCard(Icons.local_atm, 'WITHDRAW', AppColors.blue),
                    customCard(Icons.event_note, 'PERIODICAL PAY',
                        AppColors.lightBlue),
                    customCard(Icons.enhanced_encryption, 'ESCROW PAY',
                        AppColors.teal),
                    customCard(
                        Icons.swap_horiz, 'TRANSACTIONS', AppColors.lightBlue),
                  ],
                ))
              ],
            ),
          );
        });
  }

  Widget customCard(IconData iconData, String text, Color color) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(iconData, color: color),
              Text(text,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.bold))
            ],
          ),
        ));
  }
}

class MyPainter extends CustomPainter {
  double offset;

  MyPainter({
    @required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(50 + offset, 20 - offset), 5,
        Paint()..color = AppColors.lightBlue);
    canvas.drawCircle(Offset(130 + offset, 12 + offset), 12,
        Paint()..color = AppColors.lightPink);
    canvas.drawCircle(
        Offset(60 + offset, 70 + offset), 8, Paint()..color = AppColors.pink);
    canvas.drawCircle(Offset(126 + offset, 80 - offset), 16,
        Paint()..color = AppColors.lightBlue);
    canvas.drawCircle(Offset(270 + offset, 88 + offset), 5,
        Paint()..color = AppColors.whiteshPurple);
    canvas.drawCircle(Offset(320 + offset, 400 - offset), 12,
        Paint()..color = AppColors.lightBlue);
    canvas.drawCircle(Offset(170 - offset, 400 + offset), 5,
        Paint()..color = AppColors.whiteshPurple);
    canvas.drawCircle(Offset(142 + offset, 476 - offset), 10,
        Paint()..color = AppColors.lightPink);
    canvas.drawCircle(Offset(60 - offset, 320 + offset), 8,
        Paint()..color = AppColors.lightBlue);
    canvas.drawCircle(Offset(340 + offset, 280 - offset), 12,
        Paint()..color = AppColors.pink);
    canvas.drawCircle(Offset(50 + offset, 520 + offset), 8,
        Paint()..color = AppColors.whiteshPurple);
    canvas.drawCircle(Offset(420 + offset, 320 - offset), 12,
        Paint()..color = AppColors.lightPink);
    canvas.drawCircle(Offset(300 - offset, 600 + offset), 16,
        Paint()..color = AppColors.pink);
    canvas.drawCircle(Offset(50 - offset, 600 + offset), 16,
        Paint()..color = AppColors.lightBlue);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
