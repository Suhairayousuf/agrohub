
import 'dart:async';

import 'package:agrohub/features/Book/member/screen/search_member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';


import '../../../../Model/bookModel.dart';


import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';
import 'AddOflineMember.dart';


class AddMembersPage extends StatefulWidget {
  final BookModel bookData;
  const AddMembersPage({Key? key, required this.bookData}) : super(key: key);

  @override
  State<AddMembersPage> createState() => _AddMembersPageState();
}

class _AddMembersPageState extends State<AddMembersPage> {

  TextEditingController search = TextEditingController();
  TextEditingController phonNumber = TextEditingController();
  List membersList = [];
  StreamSubscription? a;

  getBook() {

    a=FirebaseFirestore.instance
        .collection('shops')
        .doc(currentshopId)
        .collection('book').doc(widget.bookData.bookId)
        .snapshots()
        .listen((event) {
      membersList=[];
      // for(var doc in event['members'] ){
      //   members.add(doc);
      //   print(members);
      //   print('ooooooooooooooooooooooooooooooooooooooo');
      //
      // }
          if(event.exists){
        membersList = event['members'] ?? [];
      }
      if (mounted) {
        setState(() {});
      }
    });
  }


  // List<UserModel> userList=[];
  // getUsers(){
  //   FirebaseFirestore.instance.collection('users').get().then((value){
  //     userList=[];
  //     for(var doc in value.docs){
  //       userList.add(UserModel.fromJson(doc.data()));
  //     }
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //
  //
  //   });
  // }
  // List searchList=[];
  // getSearchedData(String str){
  //   searchList=[];
  //   for(var searchItem in userList){
  //     if(searchItem.userName!.toLowerCase().contains(str.toLowerCase()) )
  //     {
  //       searchList.add(searchItem);
  //     }
  //   }
  //   setState(() {
  //
  //   });
  // }

  @override
  void initState() {
    getBook();
    super.initState();
  }
  @override
  void dispose() {
    a?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Add Members',style: GoogleFonts.montserrat(
          color: Colors.white
        ),),
        backgroundColor: primarycolor1,
       ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: width * 0.03,
            ),
            // Center(
            //   child: Text(
            //    // widget.bookData.bookName.toString(),
            //    'ADD MEMBER',
            //     style:  GoogleFonts.montserrat(
            //         color: primarycolor1,
            //         fontSize: width * 0.045),
            //   ),
            // ),

            // Container(
            //   width: width * 0.9,
            //   height: width * 0.13,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //         color: primarycolor1),
            //     borderRadius:
            //     BorderRadius.circular(10),
            //   ),
            //   child: TextFormField(
            //     onTap: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchMemberPage(
            //         bookData:widget.bookData
            //       )));
            //
            //     },
            //     readOnly: true,
            //     onChanged: (text){
            //
            //       // setState((){
            //       //   searchList.clear();
            //       //   if(search.text==''){
            //       //     searchList.addAll(userList);
            //       //   }else{
            //       //     getSearchedData(search.text);
            //       //   }
            //       // });
            //     },
            //     controller: search,
            //     keyboardType:
            //     TextInputType.name,
            //
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.only(left: 5,top: 15),
            //       hintText:
            //         // widget.bookData.bookName.toString(),
            //         'Edit member',
            //         hintStyle:  GoogleFonts.montserrat(
            //             color: primarycolor1.withOpacity(0.5),
            //             fontSize: width * 0.045),
            //
            //       suffixIcon: Icon(Icons.search,),
            //       disabledBorder:
            //       InputBorder.none,
            //       enabledBorder:
            //       InputBorder.none,
            //       errorBorder:
            //       InputBorder.none,
            //       border: InputBorder.none,
            //       focusedBorder:
            //       UnderlineInputBorder(
            //         borderRadius:
            //         BorderRadius.circular(
            //             15),
            //         borderSide:
            //         const BorderSide(
            //           color: Colors.white,
            //           width: 2,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Padding(
            //   padding:  EdgeInsets.only(left: width*0.05,right: width*0.05),
            //   child: IntlPhoneField(
            //     keyboardType: TextInputType.phone,
            //     controller:phonNumber,
            //     decoration: InputDecoration(
            //       hintText:
            //       'Enter your Phone number...',
            //       hintStyle:
            //       GoogleFonts.nunito( color:
            //       Colors.white,
            //         fontSize: 14,
            //         fontWeight:
            //         FontWeight.normal,),
            //       labelText: 'Phone Number',
            //       labelStyle:
            //       GoogleFonts.nunito(
            //         color:
            //         Colors.white,
            //         fontSize: 14,
            //         fontWeight:
            //         FontWeight.normal,),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.white),
            //       ),
            //     ),
            //     initialCountryCode: isoCode,
            //     onChanged: (phone) {
            //       print(phone.completeNumber);
            //       print("hiiiiiiiiiiiiiiiiiiiiiiiiiii");
            //       print(phone.countryCode);
            //
            //       // countryCode = phone.countryCode;
            //       // _phoneNumber.text = phone.completeNumber;
            //
            //     },
            //     onCountryChanged: (country) {
            //       print('Country changed to: ' + country.dialCode);
            //
            //       // countryCode='+${country.dialCode}';
            //     },
            //   ),
            // ),
            // Container(
            //   height: width * 0.17,
            //   width: width * 0.9,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: primarycolor1),
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(20),
            //     ),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 8.0),
            //     child: TextFormField(
            //       controller: phonNumber,
            //       keyboardType: TextInputType.number,
            //       decoration: InputDecoration(
            //         border: InputBorder.none,
            //         labelText: 'PhoneNumber',
            //         labelStyle:  GoogleFonts.poppins(color: primarycolor2, fontSize: 20),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding:  EdgeInsets.only(top: width*0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchMemberPage(
                          bookData:widget.bookData
                      ))).then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: width * 0.4,
                      height: width * 0.1,
                      decoration: BoxDecoration(
                          // gradient:
                          // LinearGradient(colors: [primarycolor1, primarycolor2]),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Center(
                          child: Text(
                            'Edit Members',
                            style:
                            GoogleFonts.montserrat(color: primarycolor1, fontSize: width * 0.04),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width*0.05,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddOfflineMemberPage(
                          bookData:widget.bookData
                      ))).then((value) {
                        setState(() {

                        });
                      });
                    },
                    child: Container(
                      width: width * 0.4,
                      height: width * 0.1,
                      decoration: BoxDecoration(
                          gradient:
                          LinearGradient(colors: [primarycolor1, primarycolor2]),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'Add Member',
                          style:
                          GoogleFonts.montserrat(color: Colors.white, fontSize: width * 0.04),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: width * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.bookData.bookName.toString(),
                    style:  GoogleFonts.montserrat(
                        color: primarycolor1,
                        fontWeight: FontWeight.w800,
                        fontSize: width * 0.07),
                  ),
                  Column(
                    children: [
                      Text(
                        "Credit limit",
                        style:  GoogleFonts.montserrat(
                            color: primarycolor1,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.04),
                      ),
                      Text(
                        widget.bookData.creditLimit.toString(),
                        style:  GoogleFonts.montserrat(
                            color: primarycolor1,
                            fontWeight: FontWeight.w800,
                            fontSize: width * 0.05),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () async {
            //     if(phonNumber.text!='') {
            //       bool available = false;
            //       await FirebaseFirestore.instance
            //           .collection('shops').doc(currentshopId)
            //           .collection('book')
            //           .get()
            //           .then((value) {
            //         for (var data in value.docs) {
            //           List members = data['members'];
            //           if (members.contains(phonNumber.text)) {
            //             available = true;
            //           }
            //         }
            //       });
            //       if (available == false) {
            //         showDialog(context: context,
            //             builder: (buildcontext) {
            //               return AlertDialog(
            //                 title: Text(
            //                   'Add Member', style: GoogleFonts.outfit(),),
            //                 content: Text('Do you want to Add?',
            //                     style: GoogleFonts.outfit()),
            //                 actions: [
            //                   TextButton(onPressed: () {
            //                     Navigator.pop(buildcontext);
            //                   },
            //                       child: Text(
            //                           'Cancel', style: GoogleFonts.outfit())),
            //                   TextButton(onPressed: () {
            //                     FirebaseFirestore.instance
            //                         .collection('shops')
            //                         .doc(currentshopId)
            //                         .collection('book').doc(
            //                         widget.bookData.bookId)
            //                         .update({
            //                       'members': FieldValue.arrayUnion([phonNumber.text]),
            //
            //                     });
            //                     showUploadMessage(
            //                         context, 'member added successfully',
            //                         style: GoogleFonts.outfit());
            //                     Navigator.pop(buildcontext);
            //                     Navigator.pop(context);
            //                     phonNumber.text = '';
            //
            //                     setState(() {
            //
            //                     });
            //
            //
            //                     // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => ManagePage(),), (route) => false);
            //                   },
            //                       child: const Text('Yes')),
            //                 ],
            //               );
            //             });
            //       }
            //       else {
            //         showUploadMessage(context, 'member already exist',
            //             style: GoogleFonts.outfit());
            //       }
            //     }else{
            //       showUploadMessage(context, 'Enter phone number',
            //           style: GoogleFonts.outfit());
            //     }
            //
            //
            //   },
            //   child: Container(
            //     width: width * 0.4,
            //     height: width * 0.1,
            //     decoration: BoxDecoration(
            //         gradient:
            //         LinearGradient(colors: [primarycolor1, primarycolor2]),
            //         borderRadius: BorderRadius.all(Radius.circular(10))),
            //     child: Center(
            //       child: Text(
            //         'Add Member',
            //         style:
            //         GoogleFonts.poppins(color: Colors.white, fontSize: width * 0.04),
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(
              height: width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Members',style: GoogleFonts.montserrat(
                      fontSize: 20
                  ),),
                ],
              ),
            ),
            membersList.isNotEmpty
                ? SingleChildScrollView(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                // itemCount: widget.bookData.members!.length,
                itemCount:membersList.length,

                itemBuilder: (context, index) {
                  // var member=widget.bookData.members![index];
                   var member=membersList[index];

                  return  Padding(
                    padding:  EdgeInsets.only(left: width*0.08,right: width*0.08,top:  width*0.03 ),
                    child: Container(
                      // width: width * 0.1,
                      height: width * 0.1,
                      decoration: BoxDecoration(
                          color: primarycolor1.withOpacity(0.9),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(child:
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: member.toString()).snapshots(),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData){
                                  return Container();
                                }
                                if(snapshot.data!.docs.isEmpty){
                                  return Container();
                                }
                                var user=snapshot.data!.docs[0];
                                return Text(user['userName'],
                                  style: GoogleFonts.montserrat(
                                      fontSize: width * 0.04,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600

                                  ),
                                );
                              }
                            ),
                            ),
                            InkWell(
                              // onTap: () async {

                              // },
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (BuildContext context) {
                                    return SizedBox(
                                      width: width,
                                      child: AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "Are you sure",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  color:
                                                  primarycolor1,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Do You Want Delete this member"),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width:
                                                  width * 0.15,
                                                  height:
                                                  width * 0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: GoogleFonts.montserrat(
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
                                              SizedBox(width: width*0.05,),
                                              InkWell(
                                                onTap: () async {
                                                  await FirebaseFirestore.instance
                                                      .collection("shops")
                                                      .doc(currentshopId)
                                                      .collection("book")
                                                      .doc(widget.bookData.bookId)
                                                      .update({
                                                    'members':FieldValue.arrayRemove([member])
                                                  });
                                                  setState(() {

                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: width *
                                                      0.15,
                                                  height: width *
                                                      0.08,
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    primarycolor1,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: GoogleFonts.montserrat(
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          width *
                                                              0.04,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width*0.03,),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },

                              child: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                  width: width * 0.05),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },

              ),
            )
                : SizedBox()
          ],
        ),
      )
    );
  }
}
