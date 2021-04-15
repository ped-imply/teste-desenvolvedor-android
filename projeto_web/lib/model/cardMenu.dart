import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardMenu extends StatelessWidget {
  Color color;
  String text;
  Color textColor;
  Color iconColor;
  IconData icon;
  Function onTap;

  CardMenu(
      {this.color,
      this.text,
      this.textColor,
      this.iconColor,
      this.icon,
      this.onTap});

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 4,
        child: Card(
          elevation: 2.0,
          shadowColor: Colors.grey,
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(child: Icon(icon, size: 70, color: iconColor)),
              ),
              Text(text,
                  style: GoogleFonts.openSans(fontSize: 20, color: textColor))
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
