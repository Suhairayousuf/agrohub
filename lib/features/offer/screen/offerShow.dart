// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../core/utils/utils.dart';
// import '../../auth/screen/splash.dart';
//
//
// class Offer extends StatefulWidget {
//   final String name;
//   final String description;
//   final DateTime startingDate;
//   final DateTime endingDate;
//   final File photo;
//
//   const Offer(
//       {Key? key,
//       required this.name,
//       required this.description,
//       required this.startingDate,
//       required this.endingDate,
//       required this.photo})
//       : super(key: key);
//
//   @override
//   State<Offer> createState() => _OfferState();
// }
//
// class _OfferState extends State<Offer> {
//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: width * 0.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     'Starting',
//                     style: GoogleFonts.montserrat(
//                       fontSize: width * 0.05,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     widget.startingDate.toString().substring(10, 16),
//                     style: GoogleFonts.montserrat(
//                       fontSize: width * 0.04,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     widget.startingDate.toString().substring(0, 10),
//                     style: GoogleFonts.montserrat(
//                       fontSize: width * 0.04,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Text(
//                     'Closing',
//                     style: GoogleFonts.montserrat(
//                       fontSize: width * 0.05,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     widget.endingDate.toString().substring(10, 16),
//                     style: GoogleFonts.montserrat(
//                       fontSize: width * 0.045,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     widget.endingDate.toString().substring(0, 10),
//                     style: GoogleFonts.montserrat(
//                       fontSize: width * 0.045,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: width * 0.05),
//           Text(
//             widget.name,
//             style:
//             GoogleFonts.montserrat(fontSize: width * 0.05, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(height: width * 0.04),
//           Center(
//             child: Container(
//               width: width * 0.8,
//               height: width * 0.8,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 image: DecorationImage(
//                     image: FileImage(widget.photo), fit: BoxFit.fill),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: width * 0.05,
//           ),
//           SizedBox(
//             child: Text(
//               widget.description.toString(),
//               style: GoogleFonts.montserrat(fontSize: width * 0.043,),
//             ),
//             width: width * 0.7,
//           ),
//           SizedBox(
//             height: width * 0.05,
//           ),
//           SizedBox(
//             height: width * 0.05,
//           ),
//         ],
//       ),
//     );
//   }
// }
