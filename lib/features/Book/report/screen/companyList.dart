import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Model/bookModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/selectShop.dart';

import '../../../auth/screen/splash.dart';
import 'company_report.dart';

class CompanyList extends StatefulWidget {
  const CompanyList({Key? key}) : super(key: key);

  @override
  State<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  // List<BookModel> bookList=[];
  String? text = '';

  BookModel? bookMap;


  StreamSubscription? a;
  StreamSubscription? b;

  List searchList=[];


  TextEditingController search = TextEditingController();
  @override
  void initState() {

    // getBooks();
    super.initState();
  }
  @override
  void dispose() {
    // a?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back_ios),
        // ),
        title: Text('Company Report',style: GoogleFonts.montserrat(
            color: Colors.white
        ),),
        backgroundColor: primarycolor1,
      ),
      body:  SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: width * 0.9,
                  height: 60,
                  // decoration: ShapeDecoration(
                  //   color: Color(0xFFFEFEFE),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(25),
                  //   ),
                  // ),

                  decoration: BoxDecoration(
                    color: Color(0xFFFEFEFE),

                    // border: Border.all(
                    //     color: primarycolor1),
                    borderRadius:
                    BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: TextFormField(
                      autofocus: true,
                      onFieldSubmitted: (text)  {
                        // if(text.substring(text.length-1,text.length)=='-'){

                        // await FirebaseFirestore.instance.collection('users')
                        //     .where('shopId',isEqualTo: currentshopId).
                        // where('companyName',isEqualTo: text.replaceAll('-', '')).get().then((event) {
                        //   if(event.docs.isNotEmpty){
                        //     userList=event.docs.map((e)=>UserModel.fromJson(e.data())).toList();
                        //   }
                        //
                        //   if(mounted){
                        //     setState(() {
                        //
                        //     });
                        //   }
                        //
                        //
                        // });

                        // }

                        setState(() {});
                      },

                      controller: search,
                      keyboardType:
                      TextInputType.text,

                      decoration: InputDecoration(
                        contentPadding:  const EdgeInsets.only(left: 15,bottom: 10),
                        hintText:
                        // widget.bookData.bookName.toString(),
                        'Search Company...',
                        hintStyle:  GoogleFonts.montserrat(
                            color: primarycolor1.withOpacity(0.5),
                            fontSize: width * 0.03),

                        suffixIcon: const Icon(Icons.search,color: Color(0xffB6A0A0),),
                        disabledBorder:
                        InputBorder.none,
                        enabledBorder:
                        InputBorder.none,
                        errorBorder:
                        InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder:
                        UnderlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                              15),
                          borderSide:
                          const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // search.text.isEmpty?SizedBox(
              //   height: width*0.5 ,
              //   child: Center(
              //     child: Text('No Books found',
              //       style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
              //   ),
              // ):

              StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
                  stream: FirebaseFirestore.instance.collection('shops')
                      .doc(currentshopId)
                      .snapshots(),
                  builder: (context, snapshot) {

                    print('""""""""""""currentshopId""""""""""""');
                    print(currentshopId);

                    if(!snapshot.hasData || snapshot.hasError){
                      return Center(child: CircularProgressIndicator());
                    }

                   final shopData=snapshot.data!.data();

                   List companyNames=shopData!['companies']??[];


                    return companyNames.isEmpty?
                    SizedBox(
                      height: width*0.5 ,
                      child: Center(
                        child: Text('No Companies found',
                          style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                      ),
                    ):
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount:companyNames.length ,
                        itemBuilder: (context,index){
                          return  Padding(
                            padding:  EdgeInsets.only(left:width*0.05,right: width*0.05,top: width*0.05),
                            child: InkWell(
                              onTap: () async {

                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) =>
                                      SearchCompanyBook(
                                        txt: companyNames[index],
                                        appBarText: companyNames[index], isFromList: true,
                                      )));

                              },
                              child: Container(
                                // padding: const EdgeInsets.only(right: 10,top: 20),
                                // height: 100,
                                width: width *0.7,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: const Color(0xffFBFBFB),

                                  // color: Color(0xFFFEFEFE),

                                  // border: Border.all(
                                  //     color: primarycolor1),
                                  // borderRadius:
                                  // BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 2), // changes position of shadow
                                    ),
                                  ],
                                  //  color:Colors.red
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [


                                          Expanded(
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [




                                                SvgPicture.asset("assets/company.svg"),
                                                SizedBox(width: 10,),
                                                Text(companyNames[index],
                                                  style: TextStyle(
                                                      color: Color(0xff1E1E1E),
                                                      fontSize: 18,
                                                      letterSpacing: .5,
                                                      fontWeight: FontWeight.w600
                                                  ),),


                                                ///



                                              ],
                                            ),
                                          ),

                                        ],
                                      ),

                                      SizedBox(


                                        child: FutureBuilder<AggregateQuerySnapshot>(
                                            future: FirebaseFirestore.instance.collectionGroup('book')
                                                .where('shopId',isEqualTo: currentshopId)
                                                .where('company',isEqualTo: companyNames[index].toString().toUpperCase().trim())
                                            .where('delete',isEqualTo :false)
                                                .count().get(),
                                            initialData: null,

                                            builder: (context, snapshot) {

                                              if(snapshot.data==null){
                                                return CircularProgressIndicator();
                                              }
                                              return Text((snapshot.data?.count??0).toString(),
                                                style:  GoogleFonts.montserrat(color:Color(0xFF1E1E1E),fontWeight: FontWeight.w600,fontSize: 20),);
                                            }
                                        ),



                                        ///


                                        ///

                                        // Text(userList[index].userName!,
                                        //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                                      ),
                                    ],
                                  ),
                                ),

                              ),

                              // Container(
                              //   padding: const EdgeInsets.only(right: 10,top: 20),
                              //   // height: 100,
                              //   width: 200,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     color: const Color(0xffFBFBFB),
                              //     //  color:Colors.red
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       // Container(
                              //       //   height: 60,
                              //       //   width: 70,
                              //       //   // color: Colors.red,
                              //       //   decoration: BoxDecoration(
                              //       //       image: DecorationImage(image: CachedNetworkImageProvider(statement[index].image??''),fit: BoxFit.fill)
                              //       //   ),
                              //       // ),
                              //       SizedBox(
                              //
                              //
                              //         child: Text(companyNames[index],
                              //           style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 20),),
                              //         // Text(userList[index].userName!,
                              //         //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                              //       ),
                              //       SizedBox(
                              //
                              //
                              //         child:
                              //
                              //
                              //         FutureBuilder<AggregateQuerySnapshot>(
                              //           future: FirebaseFirestore.instance.collectionGroup('book')
                              //               .where('shopId',isEqualTo: currentshopId)
                              //               .where('company',isEqualTo: companyNames[index].toString().toUpperCase())
                              //               .count().get(),
                              //           initialData: null,
                              //
                              //           builder: (context, snapshot) {
                              //
                              //             if(snapshot.data==null){
                              //               return CircularProgressIndicator();
                              //             }
                              //             return Text((snapshot.data?.count??0).toString(),
                              //               style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 20),);
                              //           }
                              //         ),
                              //         // Text(userList[index].userName!,
                              //         //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w700,fontSize: 14),),
                              //       ),
                              //     ],
                              //   ),
                              //
                              // ),

                            ),
                          );
                        });
                  }
              )


            ]
        ),
      ),
    );
  }
}
