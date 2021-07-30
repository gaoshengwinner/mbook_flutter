import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClipOvalIcon extends StatelessWidget {
  IconData icon;
  Function onTap;

  ClipOvalIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Material(
      //color: G.appBaseColor[1], // button color
      child: InkWell(
        splashColor: Colors.purpleAccent,
        // inkwell color
        child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              icon,
              //color: Colors.white,
              size: 28,
            )),
        onTap: () {
          onTap();
        },
      ),
    ));
  }
}
