import 'dart:io';

import 'package:agrohub/features/Offers/controller/offer_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Model/OfferModel/offerModel.dart';
import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../Home/screen/homePage.dart';
import '../../Home/screen/selectShop.dart';

import '../../auth/screen/splash.dart';
import 'offerList.dart';

class AddOffer extends ConsumerStatefulWidget {
  const AddOffer({Key? key}) : super(key: key);

  @override
  ConsumerState<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends ConsumerState<AddOffer> {
  TextEditingController description = TextEditingController();
  TextEditingController name = TextEditingController();
  bool isStartingDateSelected = false;
  bool isEndingDateSelected = false;
  String startingdateInString = '';
  String endingdateInString = '';
  bool _isLoading = false;
  String photourl = '';
  File? image;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndtDate = DateTime.now();
  final picker = ImagePicker();

  final format = DateFormat('dd/MM/yyyy hh:mm aaa');
  // Future uploadImageToFirebase(BuildContext context) async {
  //   Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('deposits/${image!.path}');
  //   UploadTask uploadTask = firebaseStorageRef.putFile(image!);
  //   TaskSnapshot taskSnapshot = (await uploadTask);
  //   String value = await taskSnapshot.ref.getDownloadURL();
  //
  //   // if(value!=null){
  //   //   imageList.add(value);
  //   // }
  //   setState(() {
  //     photourl = value;
  //     showUploadMessage(context, 'Upload Success', style: GoogleFonts.montserrat());
  //   });
  // }

  String imageUrl = '';
  File? file;
  final _firebaseStorage = FirebaseStorage.instance;
  pickFile(BuildContext context) async {
    final imgfile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    showUploadMessage1(context, 'Uploading...', style: GoogleFonts.montserrat());
    file = File(imgfile!.path);
    DocumentSnapshot id = await FirebaseFirestore.instance
        .collection('settings')
        .doc("settings")
        .get();
    id.reference.update({"userImage": FieldValue.increment(1)});
    var imageId = id['userImage'];

    //Upload to Firebase
    var snapshot = await _firebaseStorage.ref().child('shop/$imageId').putFile(file!);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
      // imageList.add(imageUrl);
      showUploadMessage1(context, 'Uploaded Successfully...',
          style: GoogleFonts.montserrat());
    });
    if (mounted) {
      setState(() {
        file = File(imgfile.path);
      });
    }
  }

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
              mainAxisAlignment: MainAxisAlignment.start,
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

  DateTime _selectedStartingDate = DateTime.now();
  DateTime _selectedEndingDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    DateTime date = DateTime.now();
    return Scaffold(
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
        child: Column(
          // children: [
          //
          //   SizedBox(
          //     height: width * 0.03,
          //   ),
          //   Text('Starting Date',
          //     style: TextStyle(color: primarycolor2,fontSize: width*0.05),),
          //   Container(
          //     width: width * 0.8,
          //     height: width * 0.15,
          //     // decoration: BoxDecoration(
          //     //     border: Border.all(color: primarycolor1),
          //     //     borderRadius: BorderRadius.all(Radius.circular(20))),
          //     child: DateTimeField(
          //       initialValue: DateTime.now(),
          //       format: format,
          //       onShowPicker: (context, currentValue) async {
          //         final date = await showDatePicker(
          //             context: context,
          //             firstDate: DateTime.now(),
          //             initialDate: currentValue ?? DateTime.now(),
          //             lastDate: DateTime(2100));
          //         if (date != null) {
          //           final time = await showTimePicker(
          //             context: context,
          //             initialTime: TimeOfDay.fromDateTime(
          //                 currentValue ?? DateTime.now()),
          //           );
          //           selectedStartDate = DateTime(date.year, date.month, date.day,
          //               time!.hour, time.minute);
          //
          //           return DateTimeField.combine(date, time);
          //         } else {
          //           return currentValue;
          //         }
          //       },
          //     ),
          //   ),
          //   Text('Ending Date',
          //   style: TextStyle(color: primarycolor2,fontSize: width*0.05),
          //   ),
          //
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Container(
          //         width: width * 0.8,
          //         height: width * 0.15,
          //         // decoration: BoxDecoration(
          //         //     border: Border.all(color: primarycolor1),
          //         //     borderRadius: BorderRadius.all(Radius.circular(20))),
          //         child: DateTimeField(
          //           initialValue: DateTime.now(),
          //           format: format,
          //           onShowPicker: (context, currentValue) async {
          //             final date = await showDatePicker(
          //                 context: context,
          //                 firstDate: DateTime.now(),
          //                 initialDate: currentValue ?? DateTime.now(),
          //                 lastDate: DateTime(2100));
          //             if (date != null) {
          //               final time = await showTimePicker(
          //                 context: context,
          //                 initialTime: TimeOfDay.fromDateTime(
          //                     currentValue ?? DateTime.now()),
          //               );
          //               selectedEndtDate = DateTime(date.year, date.month, date.day,
          //                   time!.hour, time.minute);
          //
          //               return DateTimeField.combine(date, time);
          //             } else {
          //               return currentValue;
          //             }
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          //   SizedBox(
          //     height: width * 0.05,
          //   ),
          //   Container(
          //     height: width * 0.17,
          //     width: width * 0.9,
          //     decoration: BoxDecoration(
          //       border: Border.all(color: primarycolor1),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(20),
          //       ),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: TextFormField(
          //         controller: name,
          //         decoration: InputDecoration(
          //           border: InputBorder.none,
          //           labelText: 'Offer Name',
          //           labelStyle: TextStyle(color: primarycolor2, fontSize: 20),
          //         ),
          //       ),
          //     ),
          //   ),
          //   SizedBox(
          //     height: width * 0.05,
          //   ),
          //   Container(
          //     height: width * 0.17,
          //     width: width * 0.9,
          //     decoration: BoxDecoration(
          //       border: Border.all(color: primarycolor1),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(20),
          //       ),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: TextFormField(
          //         controller: discription,
          //         decoration: InputDecoration(
          //           border: InputBorder.none,
          //           labelText: 'Offer Discription',
          //           labelStyle: TextStyle(color: primarycolor2, fontSize: 20),
          //         ),
          //       ),
          //     ),
          //   ),
          //   SizedBox(
          //     height: width * 0.1,
          //   ),
          //   Stack(
          //       clipBehavior: Clip.none,
          //       children: [
          //     InkWell(
          //       onTap: () {
          //         _pickImage();
          //         // print(image);
          //       },
          //       child: image == null
          //           ? Container(
          //               width: width * 0.5,
          //               height: width * 0.5,
          //               decoration: BoxDecoration(
          //                 border: Border.all(color: primarycolor1),
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(20),
          //                 ),
          //               ),
          //         child: Center(child: Text('Upload Image',style: GoogleFonts.poppins(
          //           color: primarycolor2
          //         ),)),
          //             )
          //           : Container(
          //               width: width * 0.5,
          //               height: width * 0.5,
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                     image: FileImage(image!), fit: BoxFit.fitWidth),
          //                 border: Border.all(color: primarycolor1),
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(20),
          //                 ),
          //               ),
          //
          //             ),
          //     ),
          //     Positioned(
          //       left: width * 0.43,
          //       bottom: width * 0.43,
          //       child: IconButton(
          //         onPressed: () {
          //           image = null;
          //           setState(() {});
          //         },
          //         color: primarycolor1,
          //         icon: Icon(
          //           Icons.cancel,
          //           size: width * 0.08,
          //         ),
          //       ),
          //     ),
          //   ]),
          //   SizedBox(
          //     height: width * 0.08,
          //   ),
          //   InkWell(
          //     onTap: () {
          //       if( selectedStartDate!=null&& selectedEndtDate!=null&&photourl!=''&& name.text!=''&& discription.text!=''){
          //         showDialog(context: context,
          //             builder: (buildcontext)
          //             {
          //               return AlertDialog(
          //                 title:  Text('Add Offer',style:GoogleFonts.outfit() ,),
          //                 content:  Text('Do you want to Add?',style:GoogleFonts.outfit()),
          //                 actions: [
          //                   TextButton(onPressed: (){
          //                     Navigator.pop(buildcontext);
          //                   },
          //                       child:  Text('Cancel',style:GoogleFonts.outfit())),
          //                   TextButton(onPressed: (){
          //                     FirebaseFirestore.instance.
          //                     collection('shops').doc(currentshopId).
          //                     collection('offers').add({
          //                       // "type":gender=='all users'?0:1,
          //                       'image':photourl,
          //                       'startDate':selectedStartDate??DateTime.now(),
          //                       'createdDate':FieldValue.serverTimestamp(),
          //                       'endDate':selectedEndtDate??DateTime.now(),
          //                       'shopId':currentshopId,
          //                       'title': name.text,
          //                       'description': discription.text,
          //                       'shopImage':currentShopImage,
          //
          //                     }).then((value){
          //                       value.update({
          //                         'id':value.id
          //                       });
          //
          //                     });
          //
          //                     showUploadMessage(context, 'Offers added succesfully',style: GoogleFonts.outfit());
          //                     Navigator.pop(context);
          //                     Navigator.pop(buildcontext);
          //
          //                     photourl='';
          //                     selectedEndtDate==null;
          //                     selectedStartDate==null;
          //                     setState(() {
          //
          //                     });
          //
          //                      // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => ManagePage(),), (route) => false);
          //                   },
          //                       child: const Text('Yes')),
          //                 ],
          //               );
          //
          //             });
          //
          //       }
          //       else{
          //         // gender==''?showUploadMessage(context,'Please choose type',style: GoogleFonts.outfit()):
          //         selectedStartDate==''?showUploadMessage(context,'Please select start date',style: GoogleFonts.outfit()):
          //         selectedEndtDate==''?showUploadMessage(context,'Please select end date',style: GoogleFonts.outfit()):
          //         name.text ==''?showUploadMessage(context,'Please Enter title of offer',style: GoogleFonts.outfit()):
          //         discription.text==''?showUploadMessage(context,'Please Enter description',style: GoogleFonts.outfit()):
          //         showUploadMessage(context,'Please select an image ',style: GoogleFonts.outfit());
          //       }
          //       // print(selectedStartDate);
          //       // print(selectedEndtDate);
          //       // if (selectedStartDate!='' && name.text != '') {
          //       //   Offer.add({
          //       //     'startingDate': selectedStartDate,
          //       //     'endingDate': selectedEndtDate,
          //       //     'offerName': name.text,
          //       //     'discription': discription.text,
          //       //     'photo': image,
          //       //   });
          //       //   Navigator.push(
          //       //       context,
          //       //       MaterialPageRoute(
          //       //         builder: (context) => OfferList(),
          //       //       ));
          //       // } else {
          //       //   // Offer.clear();
          //       //   print(Offer);
          //       //   print(Offer.length);
          //       // }
          //
          //     },
          //     child: Container(
          //       width: width * 0.8,
          //       height: width * 0.15,
          //       decoration: BoxDecoration(
          //           gradient:
          //               LinearGradient(colors: [primarycolor1, primarycolor2]),
          //           borderRadius: BorderRadius.all(Radius.circular(20))),
          //       child: Center(
          //         child: Text(
          //           'Add Offer',
          //           style:
          //               TextStyle(color: Colors.white, fontSize: width * 0.05),
          //         ),
          //       ),
          //     ),
          //   ),
          // ],
          children: [
            AppBar("OFFERS"),
            SizedBox(
              height: width * 0.06,
            ),
            InkWell(
              onTap: () {
                pickFile(context);
              },
              child: imageUrl == ""
                  ? Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: primarycolor1)),
                      child: Center(
                        child: Text(
                          "upload image",
                          style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: primarycolor1,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  : Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(imageUrl),fit: BoxFit.cover
                          ),
                          border: Border.all(color: primarycolor1)),
                    ),
            ),
            SizedBox(
              height: width * 0.06,
            ),
            Container(
              width: width * 0.9,
              height: width * 0.13,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: primarycolor1)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: "offer name",
                    hintStyle: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: width * 0.06,
            ),
            Container(
              width: width * 0.9,
              height: width * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: primarycolor1)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                    hintText: "offer description",
                    hintStyle: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: width * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Starting",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: width * 0.02,
                    ),
                    Container(
                      height: width * 0.15,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        color: primarycolor1,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              _selectedStartingDate= (await showOmniDateTimePicker(
                                context: context,
                                startInitialDate: DateTime.now(),
                                startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
                               startLastDate: DateTime.now().add(
                                 const Duration(days: 3652),
                               ),
                                is24HourMode: false,
                                isShowSeconds: false,
                                minutesInterval: 1,

                                // secondsInterval: 1,
                                borderRadius:  Radius.circular(16),
                                // constraints: const BoxConstraints(
                                //   maxWidth: 350,
                                //   maxHeight: 650,
                                // ),


                                // transitionBuilder: (context, anim1, anim2, child) {
                                //   return FadeTransition(
                                //     opacity: anim1.drive(
                                //       Tween(
                                //         begin: 0,
                                //         end: 1,
                                //       ),
                                //     ),
                                //     child: child,
                                //   );
                                // },
                                // transitionDuration: const Duration(milliseconds: 200),
                                // barrierDismissible: true,
                                // selectableDayPredicate: (dateTime) {
                                //   // Disable 25th Feb 2023
                                //   if (dateTime == DateTime(2023, 2, 25)) {
                                //     return false;
                                //   } else {
                                //     return true;
                                //   }
                                // },
                              ))!;
                              setState(() {

                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/date.svg",
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Text(
                                      "date",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(_selectedStartingDate),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: width * 0.15,
                            width: width * 0.002,
                            color: bgcolor,
                          ),
                          Column(
                            children: [
                              SizedBox(height: 10,),
                              Text(
                                "Time",
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                // "${_selectedStartingTime!.hour>12?(_selectedStartingTime!.hour-12).toString():_selectedStartingTime!.hour.toString()}:${_selectedStartingTime!.minute.toString().length==1?0.toString()+_selectedStartingTime!.minute.toString():_selectedStartingTime!.minute} ${_selectedStartingTime!.hour>12?"AM":"PM"}",
                                // DateFormat('hh:mmaa').format(_selectedStartingTime!),
                                // "${DateFormat('hh:mm aa').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, _selectedStartingTime!.hour, _selectedStartingTime!.minute))}",
                                DateFormat('hh:mm:aa')
                                    .format(_selectedStartingDate),
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Ending",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: width * 0.02,
                    ),
                    Container(
                      height: width * 0.15,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        color: primarycolor1,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              _selectedEndingDate= (await showOmniDateTimePicker(
                                context: context,
                                startInitialDate: DateTime.now(),
                                startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
                                startLastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                                is24HourMode: false,
                                isShowSeconds: false,
                                minutesInterval: 1,

                                // secondsInterval: 1,
                                borderRadius:  Radius.circular(16),

                                // constraints: const BoxConstraints(
                                //   maxWidth: 350,
                                //   maxHeight: 650,
                                // ),


                                // transitionBuilder: (context, anim1, anim2, child) {
                                //   return FadeTransition(
                                //     opacity: anim1.drive(
                                //       Tween(
                                //         begin: 0,
                                //         end: 1,
                                //       ),
                                //     ),
                                //     child: child,
                                //   );
                                // },
                                // transitionDuration: const Duration(milliseconds: 200),
                                // barrierDismissible: true,
                                // selectableDayPredicate: (dateTime) {
                                //   // Disable 25th Feb 2023
                                //   if (dateTime == DateTime(2023, 2, 25)) {
                                //     return false;
                                //   } else {
                                //     return true;
                                //   }
                                // },
                              ))!;
                              setState(() {

                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/date.svg",
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Text(
                                      "date",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(_selectedEndingDate),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: width * 0.15,
                            width: width * 0.002,
                            color: bgcolor,
                          ),
                          Column(
                            children: [
                              SizedBox(height: 10,),
                              Text(
                                "Time",
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(

                                  DateFormat('hh:mm:aa')
                                  .format(_selectedEndingDate),
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),)

                              // Text(
                              //   // "${_selectedStartingTime!.hour>12?(_selectedStartingTime!.hour-12).toString():_selectedStartingTime!.hour.toString()}:${_selectedStartingTime!.minute.toString().length==1?0.toString()+_selectedStartingTime!.minute.toString():_selectedStartingTime!.minute} ${_selectedStartingTime!.hour>12?"AM":"PM"}",
                              //   // DateFormat('hh:mmaa').format(_selecqtedTime!),
                              //   "${DateFormat('hh:mm aa').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, _selectedEndingTime!.hour, _selectedEndingTime!.minute))}",
                              //
                              //   style: GoogleFonts.poppins(
                              //       fontSize: 15,
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.w500),
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: width * 0.05,
            ),
            InkWell(
              onTap: () {
                // if (selectedEndtDate != null &&
                //     photourl != '' &&
                //     name.text != '' &&
                //     description.text != '') {
                //   showDialog(
                //       context: context,
                //       builder: (buildcontext) {
                //         return AlertDialog(
                //           title: Text(
                //             'Add Offer',
                //             style: GoogleFonts.outfit(),
                //           ),
                //           content: Text('Do you want to Add?',
                //               style: GoogleFonts.outfit()),
                //           actions: [
                //             TextButton(
                //                 onPressed: () {
                //                   Navigator.pop(buildcontext);
                //                 },
                //                 child: Text('Cancel',
                //                     style: GoogleFonts.outfit())),
                //             TextButton(
                //                 onPressed: () {
                //                   FirebaseFirestore.instance
                //                       .collection('shops')
                //                       .doc(currentshopId)
                //                       .collection('offers')
                //                       .add({
                //                     // "type":gender=='all users'?0:1,
                //                     'image': photourl,
                //                     'startDate':
                //                         selectedStartDate ?? DateTime.now(),
                //                     'createdDate': FieldValue.serverTimestamp(),
                //                     'endDate':
                //                         selectedEndtDate ?? DateTime.now(),
                //                     'shopId': currentshopId,
                //                     'title': name.text,
                //                     'description': description.text,
                //                     'shopImage': currentShopImage,
                //                   }).then((value) {
                //                     value.update({'id': value.id});
                //                   });
                //
                //                   showUploadMessage(
                //                       context, 'Offers added succesfully',
                //                       style: GoogleFonts.outfit());
                //                   Navigator.pop(context);
                //                   Navigator.pop(buildcontext);
                //
                //                   photourl = '';
                //                   selectedEndtDate == DateTime.now();
                //                   selectedStartDate == DateTime.now();
                //                   setState(() {});
                //
                //                   // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => ManagePage(),), (route) => false);
                //                 },
                //                 child: const Text('Yes')),
                //           ],
                //         );
                //       });
                // }
                // else {
                //   // gender==''?showUploadMessage(context,'Please choose type',style: GoogleFonts.outfit()):
                //   selectedStartDate == ''
                //       ? showUploadMessage(context, 'Please select start date',
                //           style: GoogleFonts.outfit())
                //       : selectedEndtDate == ''
                //           ? showUploadMessage(context, 'Please select end date',
                //               style: GoogleFonts.outfit())
                //           : name.text == ''
                //               ? showUploadMessage(
                //                   context, 'Please Enter title of offer',
                //                   style: GoogleFonts.outfit())
                //               : description.text == ''
                //                   ? showUploadMessage(
                //                       context, 'Please Enter description',
                //                       style: GoogleFonts.outfit())
                //                   : showUploadMessage(
                //                       context, 'Please select an image ',
                //                       style: GoogleFonts.outfit());
                // }
                // print(selectedStartDate);
                // print(selectedEndtDate);
                // if (selectedStartDate != '' && name.text != '') {
                //   Offer.add({
                //     'startingDate': selectedStartDate,
                //     'endingDate': selectedEndtDate,
                //     'offerName': name.text,
                //     'discription': description.text,
                //     'photo': image,
                //   });
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => OfferList(),
                //       ));
                // }
                // else {
                //   // Offer.clear();
                //   print(Offer);
                //   print(Offer.length);
                // }

                if(imageUrl==null ||imageUrl==""){
                  showUploadMessage1(context, 'Please select offer image', style: GoogleFonts.montserrat());
                }
                else if(name==null||name==""){
                  showUploadMessage1(context, 'Please select offer name', style: GoogleFonts.montserrat());
                }
                else if(description==null||description==""){
                  showUploadMessage1(context, 'Please select offer description', style: GoogleFonts.montserrat());
                }
                else{
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
                              "Do You Want to add the Offer"),
                          actions: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
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
                                  width: width * 0.05,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final offer=OfferModel(
                                      image: imageUrl,
                                      createdDate: DateTime.now(),
                                      startDate: _selectedStartingDate,
                                      title: name.text,
                                      description: description.text,
                                      endDate: _selectedEndingDate,
                                      shopImage: currentShopImage,
                                      shopId: currentshopId,
                                    );
                                    await addOffer(context,offer);
                                    showUploadMessage1(context, 'Offer added successfuly',
                                        style: GoogleFonts.montserrat());
                                    name.text='';
                                    imageUrl='';
                                    description.text='';
                                    description.text='';
                                    _selectedStartingDate=DateTime.now();
                                    _selectedEndingDate=DateTime.now();
                                    if(mounted){
                                      Navigator.pop(context);
                                    }
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
                                  width: width * 0.03,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );

                }
              },
              child: Container(
                width: width * 0.8,
                height: width * 0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: primarycolor1),
                child: Center(
                  child: Text(
                    'Add offer',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: width * 0.03,
            ),
          ],
        ),
      ),
    );
  }
  addOffer(BuildContext context,OfferModel offer) {
    // FirebaseFirestore.instance
    //     .collection('shops').doc(currentshopId).collection("offers")
    //     .add(offer.toJson())
    //     .then((value) {
    //   value.update({'id': value.id});
    // });
    ref.read(offerControllerProvider.notifier).addOffer(context: context,offerModel: offer);

  }
}
