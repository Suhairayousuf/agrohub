// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../auth/splash.dart';
// import '../themes/color.dart';
//
// class Report extends StatefulWidget {
//   const Report({Key? key}) : super(key: key);
//
//   @override
//   State<Report> createState() => _ReportState();
// }
//
// class _ReportState extends State<Report> {
//   bool fromDateSelected = false;
//   bool toDateSelected = false;
//   String fromDateInString = '';
//   String toDateInString = '';
//   var pickDate;
//   DateTime date = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: appbar,
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
//             height: width * 0.03,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               InkWell(
//                 onTap: () async {
//                   final datePick = await showDatePicker(
//                       context: context,
//                       initialDate: date,
//                       firstDate: DateTime(2020),
//                       lastDate: DateTime.now());
//                   if (datePick != null && datePick != pickDate) {
//                     setState(() {
//                       date = datePick;
//                       fromDateSelected = true;
//                       fromDateInString =
//                           "${date.day}/${date.month}/${date.year}";
//                     });
//                   }
//                 },
//                 child: Container(
//                   width: width * 0.45,
//                   height: width * 0.15,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: primarycolor1),
//                       borderRadius: BorderRadius.all(Radius.circular(20))),
//                   child: Center(
//                     child: Text(
//                       fromDateInString == ''
//                           ? 'From'
//                           : fromDateInString.toString(),
//                       style: GoogleFonts.montserrat(
//                           fontSize: width * 0.05, color: primarycolor2),
//                     ),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   final datePick = await showDatePicker(
//                       context: context,
//                       initialDate: date,
//                       firstDate: DateTime(2020),
//                       lastDate: DateTime.now());
//                   if (datePick != null && datePick != pickDate) {
//                     setState(() {
//                       date = datePick;
//                       toDateSelected = true;
//                       toDateInString = "${date.day}/${date.month}/${date.year}";
//                     });
//                   }
//                 },
//                 child: Container(
//                   width: width * 0.45,
//                   height: width * 0.15,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: primarycolor1),
//                       borderRadius: BorderRadius.all(Radius.circular(20))),
//                   child: Center(
//                     child: Text(
//                       toDateInString == '' ? 'To' : toDateInString.toString(),
//                       style: GoogleFonts.montserrat(
//                           fontSize: width * 0.05, color: primarycolor2),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: width * 0.04,
//           ),
//           ListView.builder(
//             itemBuilder: (context, index) {
//               return
//                 Container(
//                 width: width * 0.95,
//                 height: width * 0.25,
//                 decoration: BoxDecoration(
//                     border: Border.all( color: primarycolor1,),
//                     borderRadius: BorderRadius.all(Radius.circular(20))
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
