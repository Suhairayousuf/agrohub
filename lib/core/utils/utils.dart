
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/color.dart';
import '../../themes/pallete.dart';

var width;
var height;
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}


Future<bool?> confirmQuitDialog(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Do You want to Quit?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No')),
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Yes',
              style: TextStyle(color: Pallete.primaryColor),
            )),
      ],
    ));

void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false, required TextStyle style}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Pallete.primaryColor,
        duration: showLoading ? Duration(minutes: 30) : Duration(seconds: 4),
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message, style: GoogleFonts.outfit()),
          ],
        ),
      ),
    );
}
Future<bool?> confirmQuitDialog1(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Do You want to Change Shop?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No')),
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Yes',
              style: TextStyle(color: primarycolor1),
            )),
      ],
    ));


void showUploadMessage1(BuildContext context, String message,
    {bool showLoading = false, required TextStyle style}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: primarycolor1,
        duration: showLoading?Duration(minutes: 30):Duration(seconds: 4),
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message,style: GoogleFonts.montserrat()),
          ],
        ),
      ),
    );
}
void showErrorMessage(BuildContext context, String message,
    {bool showLoading = false, required TextStyle style}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: primarycolor1,
        duration: showLoading?Duration(minutes: 30):Duration(seconds: 10),
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Expanded(child: Text(message,style: GoogleFonts.montserrat())),
          ],
        ),
      ),
    );
}
