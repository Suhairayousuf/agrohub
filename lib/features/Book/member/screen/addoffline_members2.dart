// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'package:country_state_city/country_state_city.dart' as csc;
// import 'package:shop/model/offlineusermodel/offline_user_model.dart';
//
// import '../Home/homePage.dart';
// import '../auth/splash.dart';
// import '../model/usermodel/user_model.dart';
// import '../themes/color.dart';
// import 'AddOflineMember.dart';
//
//
//
// class AddOfflineMember2 extends StatefulWidget {
//   const AddOfflineMember2({Key? key}) : super(key: key);
//
//   @override
//   State<AddOfflineMember2> createState() => _AddOfflineMember2State();
// }
//
// class _AddOfflineMember2State extends State<AddOfflineMember2> {
//   TextEditingController _icamaController = TextEditingController();
//   TextEditingController _companynameController = TextEditingController();
//   TextEditingController _cabnameController = TextEditingController();
//   TextEditingController _dornumberController = TextEditingController();
//   TextEditingController  city= TextEditingController();
//   TextEditingController country=TextEditingController();
//   TextEditingController state=TextEditingController();
//   String? countryValue;
//   String countryShortName = 'IN';
//   String? stateValue;
//   String? cityValue;
//   List<csc.Country>? countries;
//   List<String> countriesList = [''];
//   Map<String, csc.Country> countryData = {};
//   String countryIso = '';
//
//   List<csc.State>? states;
//   List<String> statesList = [''];
//   Map<String, csc.State> stateData = {};
//   String stateIso = '';
//
//   bool read = false;
//   String url='';
//
//
//   List<csc.City>? cities;
//   List<String> citiesList = [''];
//   bool loading=false;
//   refreshPage() {
//     setState(() {
//       loading = false;
//     });
//   }
//   List _images=[];
//   List<String> _imgurl=[];
//   String? imgUrl;
//   var imgFile;
//   var uploadTask;
//   var fileUrl;
//   var docUrl;
//   var uploadTasks;
//   Future uploadImageToFirebase(BuildContext context) async {
//     Reference firebaseStorageRef =
//     FirebaseStorage.instance.ref().child('deposits/${imgFile.path}');
//     UploadTask uploadTask = firebaseStorageRef.putFile(imgFile);
//     TaskSnapshot taskSnapshot = (await uploadTask);
//     String value = await taskSnapshot.ref.getDownloadURL();
//
//     // if(value!=null){
//     //   imageList.add(value);
//     // }
//     setState(() {
//       loading=false;
//       _imgurl.add(value);
//
//       imgUrl = value;
//
//     });
//   }
//   _pickImage() async {
//     loading=true;
//
//     final imageFile = await ImagePicker.platform.pickImage(
//         source: ImageSource.camera);
//     setState(() {
//       imgFile = File(imageFile!.path);
//       _images.add(File(imgFile!.path));
//
//       uploadImageToFirebase(context);
//
//     });
//   }
//   _pickImages() async {
//     loading=true;
//
//     final imageFile = await ImagePicker.platform.pickImage(
//         source: ImageSource.gallery);
//     setState(() {
//       imgFile = File(imageFile!.path);
//       _images.add(File(imgFile!.path));
//
//       uploadImageToFirebase(context);
//     });
//   }
//
//   // getPlaceData() async {
//   //   if (institutionData != null) {
//   //     await getStates(countryData[institutionData.country].isoCode);
//   //     cities = await csc.getStateCities(
//   //         countryData[institutionData.country].isoCode,
//   //         stateData[institutionData.state].isoCode);
//   //     citiesList = cities.isEmpty ? [''] : [];
//   //     for (var a in cities) {
//   //       citiesList.add(a.name);
//   //     }
//   //     print("testing");
//   //     print(citiesList);
//   //     print(city.text);
//   //     print(institutionData.city);
//   //     print("testing");
//   //     city.text = institutionData.city;
//   //   }
//   //
//   //   if (mounted) {
//   //     setState(() {});
//   //   }
//   // }
//
//   getCountry() async {
//     countries = await csc.getAllCountries();
//     countriesList = [];
//     citiesList = [''];
//     for (var a in countries!) {
//       countriesList.add(a.name);
//       countryData[a.name] = a;
//     }
//     print(countriesList);
//     // getData();
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   getStates(var iso) async {
//     states = await csc.getStatesOfCountry(iso);
//     statesList = states!.isEmpty ? [''] : [];
//     citiesList = [''];
//     stateData = {};
//     for (var a in states!) {
//       statesList.add(a.name);
//       stateData[a.name] = a;
//     }
//     print(statesList);
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   getCities(var countryIso, var stateIso) async {
//     cities = await csc.getStateCities(countryIso, stateIso);
//     citiesList = cities!.isEmpty ? [''] : [];
//     // city.clear();
//     for (var a in cities!) {
//       citiesList.add(a.name);
//     }
//     print(citiesList);
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   String? dropdownvalue1;
//   var item1 = ['1', '2', '3'];
//
//   String? dropdownvalue2;
//   var item2 = ['A', 'B', 'C'];
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: primarycolor1,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding:  EdgeInsets.all(width * 0.07),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: width * 0.07),
//                 Text(
//                   "Welcome",
//                   style: GoogleFonts.poppins(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xffF8F7F7)),
//                 ),
//                 Text(
//                   "Please create your account",
//                   style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xffF8F7F7)),
//                 ),
//                 SizedBox(
//                   height: width * 0.05,
//                 ),
//                 SizedBox(
//                   height: width * 0.15,
//                   child: TextFormField(
//                     // autovalidateMode: AutovalidateMode.always,
//                       controller: _icamaController,
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         labelText: 'ID No',
//                         labelStyle: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         hintText: 'Enter your ID No...',
//                         hintStyle: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         filled: true,
//                         fillColor: primarycolor1,
//                         contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
//                       ),
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                       )),
//                 ),
//                 SizedBox(
//                   height: width * 0.05,
//                 ),
//                 SizedBox(
//                   height: width * 0.15,
//                   child: TextFormField(
//                       keyboardType: TextInputType.text,
//                       controller: _companynameController,
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         labelText: 'Company name',
//                         labelStyle: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         hintText: 'Enter your company name...',
//                         hintStyle: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         filled: true,
//                         fillColor: primarycolor1,
//                         contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
//                       ),
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                       )),
//                 ),
//                 SizedBox(
//                   height: width * 0.05,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: width * 0.15,
//                       width: width * 0.4,
//                       padding: EdgeInsets.only(
//                           left: width * 0.03, right: width * 0.03),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(width: 1, color: Colors.white)),
//                       child: DropdownButton(
//                         underline: Container(),
//                         hint: Text('country',
//                             style: GoogleFonts.poppins(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400)),
//                         value: dropdownvalue1,
//                         dropdownColor: Colors.blueGrey[300],
//                         icon: Icon(
//                           Icons.keyboard_arrow_down_sharp,
//                           color: Colors.white,
//                         ),
//                         iconDisabledColor: Colors.grey[100],
//                         items: item1.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Center(
//                               child: Text(
//                                 items,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             dropdownvalue1 = newValue!;
//                           });
//                         },
//                         isExpanded: true,
//                       ),
//                     ),
//                     Container(
//                       height: width * 0.15,
//                       width: width * 0.4,
//                       padding: EdgeInsets.only(
//                           left: width * 0.03, right: width * 0.03),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(width: 1, color: Colors.white)),
//                       child: DropdownButton(
//                         underline: Container(),
//                         hint: Text('city',
//                             style: GoogleFonts.poppins(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400)),
//                         value: dropdownvalue2,
//                         dropdownColor: Colors.blueGrey[300],
//                         icon: Icon(
//                           Icons.keyboard_arrow_down_sharp,
//                           color: Colors.white,
//                         ),
//                         iconDisabledColor: Colors.grey[100],
//                         items: item2.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Center(
//                               child: Text(
//                                 items,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             dropdownvalue2 = newValue!;
//                           });
//                         },
//                         isExpanded: true,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: width * 0.05,
//                 ),
//                 SizedBox(
//                   height: width * 0.15,
//                   child: TextFormField(
//                     // autovalidateMode: AutovalidateMode.always,
//                       controller: _cabnameController,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         labelText: 'Cab name ',
//                         labelStyle: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         hintText: 'Enter your cab name...',
//                         hintStyle: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         filled: true,
//                         fillColor: primarycolor1,
//                         contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
//                       ),
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                       )),
//                 ),
//                 SizedBox(
//                   height: width * 0.05,
//                 ),
//                 ///////////////////////
//                 // Column(
//                 //   children: [
//                 //     Container(
//                 //       height: 50,
//                 //       width: 120,
//                 //       decoration: BoxDecoration(
//                 //         color: Colors.white,
//                 //         borderRadius: BorderRadius.circular(12),
//                 //         boxShadow: [
//                 //           BoxShadow(
//                 //             blurRadius: 2,
//                 //             color: Color(0x4D101213),
//                 //             offset: Offset(0, 2),
//                 //           )
//                 //         ],
//                 //       ),
//                 //       child: Center(
//                 //         child: CustomDropdown.search(
//                 //           selectedStyle: TextStyle(
//                 //             fontFamily: 'Montserrat',
//                 //             fontSize: width * 0.010,
//                 //             color: Colors.black,
//                 //             fontWeight: FontWeight.w500,
//                 //           ),
//                 //           hintText: 'Select Country',
//                 //           hintStyle:
//                 //           TextStyle(color: Colors.black),
//                 //           items: countriesList,
//                 //           controller: country,
//                 //           excludeSelected: false,
//                 //           onChanged: (text) {
//                 //             read = true;
//                 //             countryShortName =
//                 //                 countryData[text]!.isoCode;
//                 //             // getStates('AF');
//                 //             countryIso =
//                 //                 countryData[text]!.isoCode;
//                 //             print(countryIso);
//                 //             state.clear();
//                 //             city.clear();
//                 //             getStates(countryIso);
//                 //             stateIso = '';
//                 //
//                 //             citiesList = [''];
//                 //
//                 //             setState(() {});
//                 //           },
//                 //         ),
//                 //       ),
//                 //     ),
//                 //     // SizedBox(
//                 //     //   width: width * 0.015,
//                 //     // ),
//                 //     Container(
//                 //       height: 50,
//                 //       width: 120,
//                 //       decoration: BoxDecoration(
//                 //           borderRadius: BorderRadius.circular(12),
//                 //           boxShadow: [
//                 //             BoxShadow(
//                 //               blurRadius: 2,
//                 //               color: Color(0x4D101213),
//                 //               offset: Offset(0, 2),
//                 //             )
//                 //           ],
//                 //           color: Colors.white),
//                 //       child: Center(
//                 //         child: CustomDropdown.search(
//                 //           selectedStyle: TextStyle(
//                 //             fontFamily: 'Montserrat',
//                 //             fontSize: width * 0.010,
//                 //             color: Colors.black,
//                 //             fontWeight: FontWeight.w500,
//                 //           ),
//                 //           hintText: 'Select State',
//                 //           hintStyle:
//                 //           TextStyle(color: Colors.black),
//                 //           items: statesList,
//                 //           controller: state,
//                 //           excludeSelected: false,
//                 //           onChanged: (text) {
//                 //             stateIso = stateData[text]!.isoCode;
//                 //             print("checking " + stateIso);
//                 //             city.clear();
//                 //             getCities(countryIso, stateIso);
//                 //             setState(() {});
//                 //           },
//                 //         ),
//                 //       ),
//                 //     ),
//                 //
//                 //     Container(
//                 //       height: 50,
//                 //       width: 120,
//                 //       decoration: BoxDecoration(
//                 //           borderRadius: BorderRadius.circular(12),
//                 //           boxShadow: [
//                 //             BoxShadow(
//                 //               blurRadius: 2,
//                 //               color: Color(0x4D101213),
//                 //               offset: Offset(0, 2),
//                 //             )
//                 //           ],
//                 //           color: Colors.white),
//                 //       child: CustomDropdown.search(
//                 //         selectedStyle: TextStyle(
//                 //           fontFamily: 'Montserrat',
//                 //           fontSize: width * 0.010,
//                 //           color: Colors.black,
//                 //           fontWeight: FontWeight.w500,
//                 //         ),
//                 //         hintText: 'Select City',
//                 //         hintStyle: TextStyle(color: Colors.black),
//                 //         items: citiesList,
//                 //         controller: city,
//                 //         excludeSelected: false,
//                 //         onChanged: (text) {
//                 //           setState(() {});
//                 //         },
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 //////////////////
//                 SizedBox(
//                   height: width * 0.15,
//                   child: TextFormField(
//                       controller: _dornumberController,
//                       decoration: InputDecoration(
//                         labelText: 'Door number',
//                         labelStyle: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         hintText: 'Enter your door number...',
//                         hintStyle: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         filled: true,
//                         fillColor: primarycolor1,
//                         contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
//                       ),
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                       )),
//                 ),
//                 SizedBox(
//                   height: width * 0.04,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: (){
//                         _images.length>1?showUploadMessage(context, "can't upload",style: GoogleFonts.poppins()): _pickImage();
//                       },
//                       child: Container(
//                         height: 30,
//                         width: 50,
//                         color: Colors.white,
//                         child: Icon(Icons.camera_alt,color: Colors.black,),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: (){
//                         _images.length>1?showUploadMessage(context, "can't upload",style: GoogleFonts.poppins()):  _pickImages();
//                       },
//                       child: Container(
//                         height: 30,
//                         width: 50,
//                         color: Colors.white,
//                         child: Icon(Icons.browse_gallery_outlined,color: Colors.black,),
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 SizedBox(
//                   height: width * 0.04,
//                 ),
//                 Container(
//                   height:100,
//                   child: ListView(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     children: [
//                       _images.isEmpty?Container(): Padding(
//                         padding:  EdgeInsets.only(left: 10),
//                         child: InkWell(
//                           onLongPress: (){
//                             _images.removeAt(0);
//                             setState(() {
//
//                             });
//                           },
//                           child: Container(
//                             height:height*0.11,
//                             width: width*0.28,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image:FileImage(_images[0]),
//                                   // FileImage(imgFile!) as ImageProvider,
//                                   fit: BoxFit.fill),
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: Color(0xffDADADA),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       _images.length==2? Padding(
//                         padding:  EdgeInsets.only(left: 10),
//                         child: InkWell(
//                           onLongPress: (){
//                             _images.removeAt(1);
//                             setState(() {
//
//                             });
//                           },
//                           child: Container(
//                             height:height*0.11,
//                             width: width*0.28,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image:FileImage(_images[1]),
//                                   // FileImage(imgFile!) as ImageProvider,
//                                   fit: BoxFit.fill),
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: Color(0xffDADADA),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ):Container(),
//                     ],
//                   ),
//
//                 ),
//                 SizedBox(
//                   height: width * 0.04,
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     if (_icamaController.text.isEmpty){
//                       refreshPage();
//                       return showUploadMessage(context,"Must Provide Icama Number", style: GoogleFonts.poppins());
//                     }else if (_companynameController.text.isEmpty){
//                       refreshPage();
//                       return showUploadMessage(context,"Please Enter company Name", style: GoogleFonts.poppins());
//                     }else if (dropdownvalue2!.isEmpty){
//                       refreshPage();
//                       return showUploadMessage(context,"Please choose city", style: GoogleFonts.poppins());
//                     }else if (dropdownvalue1!.isEmpty){
//                       refreshPage();
//                       return showUploadMessage(context,"Please choose country", style: GoogleFonts.poppins());
//                     }else if (_cabnameController.text.isEmpty){
//                       refreshPage();
//                       return showUploadMessage(context,"Please Enter cabname", style: GoogleFonts.poppins());
//                     }
//                     else if(_dornumberController.text.isEmpty){
//                       refreshPage();
//                       return showUploadMessage(context,"Please enter door number",
//                           style: GoogleFonts.poppins());
//                     }else if(_imgurl==null){
//                       refreshPage();
//                       return showUploadMessage(context,"Please upload photo", style: GoogleFonts.poppins());
//                     }
//
//                     else {
//                       // print(']]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
//                       // final qrImageData = await QrPainter(
//                       //   data: "${userDetails[0]['phone']}:${_icamaController.text}",
//                       //   version: QrVersions.auto,
//                       //   gapless: false,
//                       //   color: Colors.black,
//                       //   emptyColor: Colors.white,
//                       // ).toImageData(200.0);
//                       // final storage =  FirebaseStorage.instance;
//                       // final ref = storage.ref().child('qr_codes').child('${_icamaController.text}.png');
//                       // final uploadTask = ref.putData(qrImageData!.buffer.asUint8List());
//                       //
//                       // await uploadTask.whenComplete(() async {
//                       //   url = await ref.getDownloadURL();
//                       //
//                       //   print(url.toString());
//                       //   print('111111111111111111111');
//                       //
//                       // });
//                       Map map =
//                       {
//                         "icamaNumber": _icamaController.text,
//                         "companyName": _companynameController.text,
//                         "country": dropdownvalue1,
//                         "city": dropdownvalue2,
//                         "cabName": _cabnameController.text,
//                         "doorNumber": _dornumberController.text,
//                         "cardImage": _imgurl
//                       };
//                       userDetails.insert(1, map);
//
//                       // FirebaseAuth.instance.createUserWithEmailAndPassword(email: userDetails[0]['userEmail']??'', password:userDetails[0]['password']??"").then((value) {
//                         var user = OfflineUserModel(
//                           status: 0,
//                           phone: userDetails[0]['phone'] ?? '',
//                           userEmail: userDetails[0]['userEmail'] ?? '',
//                           userName: userDetails[0]['userName'] ?? '',
//                           // password: userDetails[0]['password'] ?? "",
//                           // token: [],
//                           // userId: value.user!.uid,
//                           userId:'',
//                           createdDate: DateTime.now(),
//                           icamaNumber: userDetails[1]['icamaNumber'] ?? "",
//                           cardImage: userDetails[1]['cardImage'] ?? [],
//                           doorNumber: userDetails[1]['doorNumber'] ?? "",
//                           city: userDetails[1]['city'] ?? "",
//                           cabName: userDetails[1]['cabName'] ?? "",
//                           code: "",
//                           companyName: userDetails[1]['companyName'] ?? '',
//                           country: userDetails[1]['country'] ?? "",
//                           // qrImage: url.toString(),
//                         );
//                         createUser(user);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => HomePage(),
//                             ));
//                       // });
//
//                     }
//                   },
//                   child: Container(
//                     height: width * 0.13,
//                     width: width * 1,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(38),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color(0xff323333).withOpacity(0.25),
//                               blurRadius: 6,
//                               spreadRadius: 0,
//                               offset: Offset(4, 3))
//                         ]),
//                     child: Center(
//                       child: Text(
//                         "Sign Up",
//                         style: GoogleFonts.poppins(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xff6E788E)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: width * 0.25,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Alreay have an account?",
//                       style: GoogleFonts.poppins(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xffFFFFFF).withOpacity(0.70)),
//                     ),
//                     SizedBox(
//                       width: width * 0.015,
//                     ),
//                     Text(
//                       "Log in",
//                       style: GoogleFonts.poppins(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xffFFFFFF)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   createUser(OfflineUserModel user) async {
//
//
//     FirebaseFirestore.instance
//         .collection('offlineUsers').
//     // doc(user.userId).
//     add(user.toJson());
//
//   }
// }