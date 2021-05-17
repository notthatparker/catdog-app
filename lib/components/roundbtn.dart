/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Roundedbutton extends StatelessWidget {
  Roundedbutton(
      {required this.title, required this.color, required this.onPressed});
  final Color color;
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 150,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          decoration: BoxDecoration(
              color: Colors.amber[900],
              borderRadius: BorderRadius.circular(10)),
          child: Text('Take a Photo', style: TextStyle(color: Colors.white)),
        ));
  }
}

class WhiteRoundedbutton extends StatelessWidget {
  WhiteRoundedbutton(
      {required this.title, required this.color, required this.onPressed});
  final Color color;
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 15.0,
        // shadowColor: Color.fromARGB(120, 209, 20, 19),
        color: this.color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () => onPressed(),
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
*/
