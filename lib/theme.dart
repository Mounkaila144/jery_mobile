import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class themejolie extends StatelessWidget {
  const themejolie({
    Key? key,required this.donner,
  }) : super(key: key);
  final Widget donner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blue.shade900,
              Colors.blue.shade800,
              Colors.blue.shade400
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child:donner
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
