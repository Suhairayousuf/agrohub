import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:onscreen_keyboard/data/loading.dart';

import '../../../../Model/bookModel.dart';
import '../../../../Model/usermodel/user_model.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../auth/screen/splash.dart';
import 'AddOflineMember.dart';
import 'edit_member.dart';

class SearchMemberPage extends StatefulWidget {
  final BookModel bookData;
  const SearchMemberPage({Key? key, required this.bookData}) : super(key: key);

  @override
  State<SearchMemberPage> createState() => _SearchMemberPageState();
}

class _SearchMemberPageState extends State<SearchMemberPage> {
  List<UserModel> userList=[];
  Map bookUser={};
  getUsers(){
    if(widget.bookData.members!.isNotEmpty){
      FirebaseFirestore.instance
          .collection('users')
          .where('userEmail', whereIn: widget.bookData.members)
          .get()
          .then((value) {
        userList = [];
        bookUser = {};
        for (var doc in value.docs) {

          bookUser[doc.get('userEmail')] = doc.data();
          userList.add(UserModel.fromJson(doc.data()));

        }
        _isLoading=false;
        if (mounted) {
          setState(() {});
        }
      });
    }
  }
  bool _isLoading = true;
  List searchList=[];
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
  TextEditingController search = TextEditingController();
@override
  void initState() {

  getUsers();
  // if(mounted){
  //     Timer(Duration(seconds: 1), () {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }

    super.initState();
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
        title: Text('Edit Members',style: GoogleFonts.montserrat(
            color: Colors.white
        ),),
        backgroundColor: primarycolor1,
      ),
      body: _isLoading
          ? Center(
        child: LoadingAnimationWidget.halfTriangleDot(
            size: 50, color: primarycolor1),
      ):
      SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 18.0,right: 10,top: 8),
            //   child: Container(
            //     width: width * 0.9,
            //     height: width * 0.13,
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //           color: primarycolor1),
            //       borderRadius:
            //       BorderRadius.circular(10),
            //     ),
            //     child: TextFormField(
            //
            //
            //       onChanged: (text){
            //
            //         setState((){
            //           searchList.clear();
            //           if(search.text==''){
            //             searchList.addAll(userList);
            //           }else{
            //             getSearchedData(text);
            //           }
            //         });
            //       },
            //       controller: search,
            //       keyboardType:
            //       TextInputType.name,
            //
            //       decoration: InputDecoration(
            //         contentPadding: EdgeInsets.only(left: 5,top: 5),
            //         hintText:
            //         // widget.bookData.bookName.toString(),
            //         'Search member',
            //         hintStyle:  GoogleFonts.montserrat(
            //             color: primarycolor1.withOpacity(0.5),
            //             fontSize: width * 0.045),
            //
            //         suffixIcon: Icon(Icons.search,),
            //         disabledBorder:
            //         InputBorder.none,
            //         enabledBorder:
            //         InputBorder.none,
            //         errorBorder:
            //         InputBorder.none,
            //         border: InputBorder.none,
            //         focusedBorder:
            //         UnderlineInputBorder(
            //           borderRadius:
            //           BorderRadius.circular(
            //               15),
            //           borderSide:
            //           const BorderSide(
            //             color: Colors.white,
            //             width: 2,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
           // search.text!='' && searchList.length==0?
           // Padding(
           //   padding:  EdgeInsets.only(top: width*0.08),
           //   child: InkWell(
           //     onTap: (){
           //        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddOfflineMemberPage(
           //            bookData:widget.bookData
           //        )));
           //     },
           //     child: Container(
           //       width: width * 0.4,
           //       height: width * 0.1,
           //       decoration: BoxDecoration(
           //           gradient:
           //           LinearGradient(colors: [primarycolor1, primarycolor2]),
           //           borderRadius: BorderRadius.all(Radius.circular(10))),
           //       child: Center(
           //         child: Text(
           //           'Add Member',
           //           style:
           //           GoogleFonts.montserrat(color: Colors.white, fontSize: width * 0.04),
           //         ),
           //       ),
           //     ),
           //   ),
           // ):
            widget.bookData.members?.length==0?
           Container(
             height: width,
             child: Center(
               child: Text(
                 'No Member Found',
                 style:
                 GoogleFonts.montserrat(color: Colors.black, fontSize: width * 0.03),
               ),
             ),
           ):
            ListView.builder(
              shrinkWrap: true
              ,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.bookData.members?.length,
              itemBuilder: (context, index) {

                // UserModel data = userList[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20,left: 10, right: 10),
                  child: InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookReportPage(
                      //   bookId:data.bookId,
                      // )));
                    },
                    child: Container(
                      // padding: EdgeInsets.only(left: 10, right: 10),
                      height: height * 0.11,
                      width: width * 0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: primarycolor1,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1), // shadow color
                            blurRadius: 15, // shadow radius
                            offset: Offset(5, 10), // shadow offset
                            spreadRadius: 0.4, // The amount the box should be inflated prior to applying the blur
                            blurStyle: BlurStyle.normal, // set blur style
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  bookUser[widget.bookData.members![index]]['userName']??"",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white
                                  ),
                                ),

                                // Text(
                                //   data.icamaNumber ?? "",
                                //   style: GoogleFonts.montserrat(
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.w800,
                                //       color: Colors.white
                                //   ),
                                // ),

                              ],
                            ),
                            InkWell(
                              onTap: () async {

                                  // bool available = false;
                                  // await FirebaseFirestore.instance
                                  //     .collection('shops').doc(currentshopId)
                                  //     .collection('book').where('bookId',isEqualTo: widget.bookData.bookId)
                                  //     .get()
                                  //     .then((value) {
                                  //   for (var doc in value.docs) {
                                  //     List members = doc['members'];
                                  //     // if (members.contains(data.icamaNumber)) {
                                  //     //   available = true;
                                  //     // }
                                  //   }
                                  // });
                                  // if (available == false) {
                                  //   showDialog(context: context,
                                  //       builder: (buildcontext) {
                                  //         return AlertDialog(
                                  //           title: Text(
                                  //             'Add Member', style: GoogleFonts.montserrat(),),
                                  //           content: Text('Do you want to Add?',
                                  //               style: GoogleFonts.montserrat()),
                                  //           actions: [
                                  //             TextButton(onPressed: () {
                                  //               Navigator.pop(buildcontext);
                                  //             },
                                  //                 child: Text(
                                  //                     'Cancel', style: GoogleFonts.montserrat())),
                                  //             TextButton(onPressed: () {
                                  //               FirebaseFirestore.instance
                                  //                   .collection('shops')
                                  //                   .doc(currentshopId)
                                  //                   .collection('book').doc(
                                  //                   widget.bookData.bookId)
                                  //                   .update({
                                  //                 // 'members': FieldValue.arrayUnion([userList[index].icamaNumber]),
                                  //
                                  //               });
                                  //               showUploadMessage(
                                  //                   context, 'member added successfully',
                                  //                   style: GoogleFonts.montserrat());
                                  //               Navigator.pop(buildcontext);
                                  //               Navigator.pop(context);
                                  //               // phonNumber.text = '';
                                  //
                                  //               setState(() {
                                  //
                                  //               });
                                  //
                                  //
                                  //               // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => ManagePage(),), (route) => false);
                                  //             },
                                  //                 child: const Text('Yes')),
                                  //           ],
                                  //         );
                                  //       });
                                  // }
                                  // else {
                                  //   showUploadMessage(context, 'member already exist',
                                  //       style: GoogleFonts.montserrat());
                                  // }
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditMember(
                                    // bookData:widget.bookData
                                   userData:UserModel.fromJson(bookUser[widget.bookData.members![index]]),
                                  bookMembers: widget.bookData.members??[], shopId: widget.bookData.shopId??'', bookId: widget.bookData.bookId??'',
                                )));

                              },
                              child: Container(
                                width: width * 0.15,
                                height: width * 0.09,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: primarycolor1),
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text('Edit',style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: primarycolor1
                                  ),),
                                )
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      ]
        ),
      ),
    );
  }

}


