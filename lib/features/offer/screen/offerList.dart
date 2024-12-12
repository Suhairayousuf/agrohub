// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// import '../Home/selectShop.dart';
// import '../auth/splash.dart';
// import '../themes/color.dart';
// import 'offerShow.dart';
//
// class OfferList extends StatefulWidget {
//   const OfferList({Key? key}) : super(key: key);
//
//   @override
//   State<OfferList> createState() => _OfferListState();
// }
//
// class _OfferListState extends State<OfferList> {
//   @override
//   Widget build(BuildContext context) {
//     width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: appbar,
//         // leading: IconButton(
//         //   onPressed: () {
//         //     Navigator.pop(context);
//         //   },
//         //   icon: Icon(Icons.arrow_back_ios),
//         // ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SingleChildScrollView(
//               child: ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: offer.length,
//                 itemBuilder: (context, index) {
//                   print(offer.length);
//                   print('[[[[[[[[[[[[[[[[[[[MyBook]]]]]]]]]]]]]]]]]]]');
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: InkWell(
//                         onTap: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) => Offer(
//                           //       name: offer[index]['offerName'],
//                           //       description: offer[index]['description'],
//                           //       startingDate: offer[index]['startingDate'],
//                           //       endingDate: offer[index]['endingDate'],
//                           //       photo: offer[index]['photo'],
//                           //     ),
//                           //   ),
//                           // );
//                         },
//                         child: Container(
//                             width: width * 0.95,
//                             height: width * 0.45,
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: primarycolor1),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(20))),
//                             child: Row(
//                               children: [
//                                 // Container(
//                                 //   height: width * 0.45,
//                                 //   width: width * 0.4,
//                                 //   decoration: BoxDecoration(
//                                 //     borderRadius: BorderRadius.only(
//                                 //         topLeft: Radius.circular(20),
//                                 //         bottomLeft: Radius.circular(20)),
//                                 //     image: DecorationImage(
//                                 //         image: FileImage(offer[index]['photo']),
//                                 //         fit: BoxFit.fill),
//                                 //   ),
//                                 // ),
//                                 SizedBox(
//                                   width: width * 0.05,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height: width * 0.03,
//                                     ),
//                                     // Text(
//                                     //   offer[index]['offerName'],
//                                     //   style: TextStyle(
//                                     //       fontSize: width * 0.055,
//                                     //       fontWeight: FontWeight.w500),
//                                     // ),
//                                     SizedBox(
//                                       height: width * 0.03,
//                                     ),
//                                     // Text(
//                                     //   offer[index]['startingDate']
//                                     //       .toString()
//                                     //       .substring(0, 16),
//                                     //   style: TextStyle(
//                                     //       fontSize: width * 0.04,
//                                     //       fontWeight: FontWeight.w500),
//                                     // ),
//                                     Text('To'),
//                                     // Text(
//                                     //   offer[index]['endingDate']
//                                     //       .toString()
//                                     //       .substring(0, 16),
//                                     //   style: TextStyle(
//                                     //       fontSize: width * 0.04,
//                                     //       fontWeight: FontWeight.w500),
//                                     // ),
//                                     SizedBox(
//                                       height: width * 0.03,
//                                     ),
//                                    //  offer[index]['description']==''
//                                    //  ? SizedBox()
//                                    // : Container(
//                                    //      width: width * 0.45,
//                                    //      child: Text(
//                                    //        offer[index]['description'],
//                                    //        style: TextStyle(
//                                    //            fontSize: width * 0.05,
//                                    //            overflow: TextOverflow.ellipsis),
//                                    //      ))
//                                   ],
//                                 )
//                               ],
//                             ))),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
