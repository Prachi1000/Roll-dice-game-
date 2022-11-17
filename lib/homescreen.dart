import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftdiceno = 1;
  int rightdiceno = 1;
  late AnimationController _controller;
  late CurvedAnimation animation =
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    var animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.addListener(() {
      setState(() {});
      print(_controller.value);
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftdiceno = Random().nextInt(6) + 1;
          rightdiceno = Random().nextInt(6) + 1;
        });
        print('Completed');
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dicee',
          // margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
        ),
        // margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage(
                            'assets/images/dice-png-$leftdiceno.png'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image(
                          height: 200 - (animation.value) * 200,
                          image: AssetImage(
                              'assets/images/dice-png-$rightdiceno.png')),
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: roll,
              // style: ElevatedButton.styleFrom(
              //   primary: Colors.green,
              //   padding: EdgeInsets.all(8.0),
              // ),
              child: Text(
                'Roll',
                style: TextStyle(fontWeight: FontWeight.bold),
                // margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
