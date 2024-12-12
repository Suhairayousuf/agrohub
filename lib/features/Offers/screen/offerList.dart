import 'dart:core';

import 'package:agrohub/features/Home/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../Model/OfferModel/offerModel.dart';
import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../Home/screen/homePage.dart';
import '../../Home/screen/selectShop.dart';
import '../../auth/screen/splash.dart';
import '../controller/offer_controller.dart';
import 'OfferSinglePage.dart';

class OfferList extends ConsumerStatefulWidget {
  const OfferList({Key? key}) : super(key: key);

  @override
  ConsumerState<OfferList> createState() => _OfferListState();
}

class _OfferListState extends ConsumerState<OfferList> {
  // Duration myDuration=Duration(hours: 2);

  // Future<void> startTimer()async{
  //   myDuration=Duration(seconds: );
  // }

  // List<OfferModel> offersList = [];
 // final offersList = StateProvider<OfferModel>((ref) => []);

  // getOffers() async {
  //   ref.read(offersList.notifier).state=await ref.watch(getOfferProvider);
  //   // FirebaseFirestore.instance
  //   //     .collection('shops')
  //   //     .doc(currentshopId)
  //   //     .collection('offers')
  //   //     .get()
  //   //     .then((value) {
  //   //   offersList = [];
  //   //   for (var doc in value.docs) {
  //   //     offersList.add(OfferModel.fromJson(doc.data()));
  //   //     print(offersList);
  //   //     print('offersList');
  //   //   }
  //   //   if (mounted) {
  //   //     setState(() {});
  //   //   }
  //   // });
  // }

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
                // IconButton(
                //     onPressed: () => Navigator.pop(context),
                //     icon: Icon(
                //       Icons.arrow_back_ios,
                //       color: Colors.white,
                //     )),
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

  @override
  void initState() {
  //  getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(offer.length);
    print(offer.length);
    return Scaffold(
      backgroundColor: bgcolor,
      body: Consumer(
        builder: (context,ref,child) {
          final offer=ref.watch(getOfferProvider);
        return  offer.when(data: (offersList){
            return Column(
              children: [
                AppBar("OFFERS"),
                offersList.length == 0
                    ? Center(
                  child: Text(
                    'No offers found',
                    style: GoogleFonts.montserrat(color: primarycolor2),
                  ),
                )
                    : Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount: offersList.length,
                    itemBuilder: (context, index) {
                      OfferModel data = offersList[index];
                      return  DateTime.now()
                          .isAfter(data.endDate!) ?Container():ListOffer(data: data);
                    },
                  ),
                ),
              ],
            );
          }, error: (error,stack){
            return Text(error.toString());
          }, loading: (){
            return CircularProgressIndicator();
          });

        }
      ),
    );
  }
}

class ListOffer extends StatefulWidget {
  final OfferModel data;

  const ListOffer({Key? key, required this.data}) : super(key: key);

  @override
  State<ListOffer> createState() => _ListOfferState();
}

class _ListOfferState extends State<ListOffer> {
  Duration? remainingTime=Duration(days: 0);

  getTime() async {
    for (int i = 1; i > 0; i--) {
      await Future.delayed(Duration(seconds: 0));
      remainingTime = widget.data.endDate?.difference(DateTime.now());
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
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferSinglePage(
                name: widget.data.title.toString(),
                description: widget.data.description.toString(),
                startingDate: widget.data.startDate!,
                endingDate: widget.data.endDate!,
                photo: widget.data.image.toString(),
              ),
            ),
          );
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (buildcontext) {
                return AlertDialog(
                  title: Text(
                    'Delete',
                    style: GoogleFonts.montserrat(),
                  ),
                  content: Text('Are you sure?', style: GoogleFonts.montserrat()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel', style: GoogleFonts.montserrat())),
                    TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('shops')
                              .doc(currentshopId)
                              .collection('offers')
                              .doc(widget.data.id)
                              .delete();

                          Navigator.pop(context);
                          showUploadMessage1(context, "Deleted",
                              style: GoogleFonts.montserrat());
                        },
                        child: Text('Delete', style: GoogleFonts.montserrat())),
                  ],
                );
              });
        },
        child: Container(
          width: width * 0.95,
          // height: width * 0.47,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(11))),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.03,
              ),
              Container(
                height: width * 0.42,
                width: width * 0.34,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          widget.data.image.toString(),
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                width: width * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: width * 0.02,
                  ),
                  Container(
                    // width: width * 0.40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //     DateTime.now()
                        //         .isAfter(widget. data.endDate!)
                        //         ? "Expired"
                        //         : "Available",
                        //     style: DateTime.now()
                        //         .isAfter(widget. data.endDate!)
                        //         ? GoogleFonts.montserrat(
                        //         fontSize: width * 0.03,
                        //         color: Colors.red,
                        //         fontWeight:
                        //         FontWeight.w600)
                        //         : GoogleFonts.montserrat(
                        //         fontSize: width * 0.03,
                        //         color: Colors.green,
                        //         fontWeight:
                        //         FontWeight.w600)),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * 0.03,
                  ),
                  DateTime.now()
                      .isAfter(widget. data.endDate!)
                      ?Container():Container(
                    height: width * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    
                    child:Row(
                      children: [
                        Text(
                          "${remainingTime?.inDays.toString()}d:",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${remainingTime?.inHours.remainder(24).toString()}h:",
                          style: GoogleFonts.montserrat(
                              color:  Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${remainingTime?.inMinutes.remainder(60)}m:",
                          style: GoogleFonts.montserrat(
                            color:  Colors.white,
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${remainingTime?.inSeconds.remainder(60).toString()}s",
                          style: GoogleFonts.montserrat(
                              color:  Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ),
                  SizedBox(
                    height: width * 0.03,
                  ),
                  Text(
                    widget.data.title.toString(),
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: width * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy').format(widget.data.startDate!),
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '-',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(widget.data.endDate!),
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: width * 0.03,
                  ),
                  widget.data.description == ''
                      ? SizedBox()
                      : Container(
                          width: width * 0.45,
                          child: Text(
                            widget.data.description.toString(),
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )),
                  Container(
                    width: width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DateTime.now().isAfter(widget.data.endDate!)
                            ? InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        width: width,
                                        child: AlertDialog(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Are you sure",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    color: primarycolor1,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                              "Do You Want Delete the Offer"),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("shops")
                                                        .doc(currentshopId)
                                                        .collection("offers")
                                                        .doc(widget.data.id)
                                                        .delete();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: width * 0.15,
                                                    height: width * 0.08,
                                                    decoration: BoxDecoration(
                                                      color: primarycolor1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Yes",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.04,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.05,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: width * 0.15,
                                                    height: width * 0.08,
                                                    decoration: BoxDecoration(
                                                      color: primarycolor1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "No",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.04,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child:
                                    SvgPicture.asset("assets/icons/delete.svg"),
                              )
                            : Text(""),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
