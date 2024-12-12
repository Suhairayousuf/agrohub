import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../auth/screen/splash.dart';



class OfferSinglePage extends StatefulWidget {
  final String name;
  final String description;
  final DateTime startingDate;
  final DateTime endingDate;
  final String photo;

  const OfferSinglePage(
      {Key? key,
        required this.name,
        required this.description,
        required this.startingDate,
        required this.endingDate,
        required this.photo,
      }
      )
      : super(key: key);

  @override
  State<OfferSinglePage> createState() => _OfferSinglePageState();
}

class _OfferSinglePageState extends State<OfferSinglePage> {

  AppBar(String title) {
    return Container(
      width: width,
      height: width * 0.4,
      child: Stack(
        children: [
          Container(
            width: width * 1,
            height: width * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/appBar.png"), fit: BoxFit.cover),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.07,
                ),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: width * 0.65,
                ),
              ],
            ),
          ),
          Positioned(
            top: width * 0.3,
            height: width * 0.13,
            child: Container(
              decoration: BoxDecoration(
                color: bgcolor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.11),
                    topRight: Radius.circular(32.11)),
              ),
              width: width,
              height: width * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: primarycolor1,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Duration? remainingTime=Duration(days: 0);

  getTime() async {
    for (int i = 1; i > 0; i--) {
      await Future.delayed(Duration(seconds: 0));
      remainingTime = widget.endingDate.difference(DateTime.now());
    }
    if (mounted) {
      setState(() {});
    }
    getTime();
  }

  @override
  void initState() {
    getTime();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
      body: Column(
        children: [
          AppBar(widget.name),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Column(
          //       children: [
          //         Text(
          //           'Starting',
          //           style: GoogleFonts.montserrat(
          //             fontSize: width * 0.03,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //         Text(
          //           DateFormat('dd/MM/yyyy')
          //               .format(widget.startingDate),
          //           style: GoogleFonts.montserrat(
          //             fontSize: width * 0.045,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //         Text(
          //           DateFormat('hh:mm:aa')
          //               .format(widget.startingDate),
          //           style: GoogleFonts.montserrat(
          //             fontSize: width * 0.045,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Text(
          //           'Closing',
          //           style: GoogleFonts.montserrat(
          //             fontSize: width * 0.03,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //         Text(
          //           DateFormat('dd/MM/yyyy')
          //               .format( widget.endingDate),
          //           style: GoogleFonts.montserrat(
          //             fontSize: width * 0.045,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //         Text(
          //           DateFormat('hh:mm:aa')
          //               .format( widget.endingDate),
          //           style: GoogleFonts.montserrat(
          //             fontSize: width * 0.045,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //
          //       ],
          //     ),
          //   ],
          // ),
          SizedBox(height: width * 0.05),
          Container(
            width: width*0.8,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    DateTime.now()
                        .isAfter(widget.endingDate)
                        ? "Expired"
                        : "Available",
                    style: DateTime.now()
                        .isAfter(widget.endingDate)
                        ? GoogleFonts.montserrat(
                        fontSize: width * 0.04,
                        color: Colors.red,
                        fontWeight:
                        FontWeight.w600)
                        : GoogleFonts.montserrat(
                        fontSize: width * 0.04,
                        color: Colors.green,
                        fontWeight:
                        FontWeight.w600)),
                DateTime.now()
                    .isAfter(widget.endingDate)
                    ?Container():Row(
                  children: [
                    Text(
                      "${remainingTime?.inDays.toString()}d:",
                      style: GoogleFonts.montserrat(
                          color: primarycolor1,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${remainingTime?.inHours.remainder(24).toString()}h:",
                      style: GoogleFonts.montserrat(
                          color: primarycolor1,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${remainingTime?.inMinutes.remainder(60)}m:",
                      style: GoogleFonts.montserrat(
                        color: primarycolor1,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${remainingTime?.inSeconds.remainder(60).toString()}s",
                      style: GoogleFonts.montserrat(
                          color: primarycolor1,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: width * 0.04),
          Center(
            child: Container(
              width: width * 0.9,
              height: width * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(image:
                CachedNetworkImageProvider(widget.photo),fit: BoxFit.fill
                ),
                borderRadius: BorderRadius.circular(20),

              ),
            ),
          ),
          SizedBox(
            height: width * 0.05,
          ),
          SizedBox(
            child: Text(
              widget.description.toString(),
              style: GoogleFonts.montserrat(fontSize: width * 0.045,fontWeight: FontWeight.w500),
            ),
            width: width * 0.7,
          ),
          SizedBox(
            height: width * 0.05,
          ),
          SizedBox(
            height: width * 0.05,
          ),
        ],
      ),
    );
  }
}