import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(GDG100MetersTimerApp());

class GDG100MetersTimerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GDG100MetersTimerAppState();
  }
}

class GDG100MetersTimerAppState extends State<GDG100MetersTimerApp> {

  // declare and initialize varibles
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to GDG 100 Meters',
      home: Scaffold(
        appBar: AppBar(
          title: new Text('Timer'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                      timing: 'HOURS', value: hours.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      timing: 'MIN', value: minutes.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      timing: 'SEC', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: FlatButton(
                  color: Colors.blueGrey,
                  child: Text(isActive ? 'STOP' : 'START TIMER', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({this.timing, this.value});

  final String timing;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$timing',
            style: TextStyle(
              color: Colors.white60,
            ),
          )
        ],
      ),
    );
  }
}
