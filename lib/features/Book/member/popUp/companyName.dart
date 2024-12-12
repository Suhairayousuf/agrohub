import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';

class SelectCompanyName extends StatefulWidget {
  final String t;
  const SelectCompanyName({Key? key, required this.t}) : super(key: key);

  @override
  State<SelectCompanyName> createState() => _SelectCompanyNameState();
}

class _SelectCompanyNameState extends State<SelectCompanyName> {

  List availableNames=[];
  
  List checkName(String txt) {
    List a=[];
    for(String i in companyNames) {
      if(i.toUpperCase().contains(txt.toUpperCase())) {
        a.add(i);
      }
    }
    
    return a;
  }

 late TextEditingController search ;

  @override
  void initState() {
    search = TextEditingController(text: widget.t);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    print('""""""""companyNames""""""""');
    print(companyNames);
    return  AlertDialog(
      content: Container(
        width: width * 0.8,
        height: height*0.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: width * 0.9,

                  decoration: BoxDecoration(
                    border: Border.all(
                        color: primarycolor1),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    onChanged: (text)  async {
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

                      availableNames= await checkName(search.text);

                      setState(() {});
                    },

                    controller: search,
                    keyboardType: TextInputType.text,

                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15,top: 10),
                      hintText:
                      // widget.bookData.bookName.toString(),
                      'Search Company',
                      hintStyle:  GoogleFonts.montserrat(
                          color: primarycolor1.withOpacity(0.5),
                          fontSize: width * 0.045),

                      suffixIcon: const Icon(Icons.search,),
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

              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount:search.text.isEmpty?
                  0:
                      companyNames.contains(search.text)?
                          availableNames.length
                          :
                  availableNames.length +1,
                  itemBuilder: (context,index){
                    return  index==0?
                    companyNames.contains(search.text)?

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: ()  {
                          Navigator.pop(context,availableNames[index]);

                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 10,top: 20),
                          // height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFBFBFB),
                            //  color:Colors.red
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Container(
                                  //   height: 60,
                                  //   width: 70,
                                  //   // color: Colors.red,
                                  //   decoration: BoxDecoration(
                                  //       image: DecorationImage(image: CachedNetworkImageProvider(statement[index].image??''),fit: BoxFit.fill)
                                  //   ),
                                  // ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(statement[index].bookName,
                                      //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w800,fontSize: 20),),


                                      Text(availableNames[index]),

                                      // Text(statement[index].shopName??"",
                                      //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                      // const SizedBox(height: 5,),

                                      // Text(statement[index].bookName??"",
                                      //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                      // const SizedBox(height: 5,),



                                      // statement[index].noBook==true?
                                      // Text('No Book', style: GoogleFonts.montserrat(color:Colors.red,fontWeight: FontWeight.w800,fontSize: 14),):Container()


                                    ],
                                  )
                                ],
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     // statement[index].noBook==false?
                              //     Row(
                              //       children: [
                              //         Text(statement[index].currencyShort.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                              //         const SizedBox(width: 3,),
                              //         Text(statement[index].amount.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                              //       ],
                              //     ),
                              //
                              //
                              //
                              //   ],
                              // ),

                              // SizedBox(width: 5,),


                            ],
                          ),

                        ),
                      ),
                    ):
                         Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: ()  {

                          showDialog(context: context,
                              builder: (buildcontext) {
                                return AlertDialog(
                                  title: Text(
                                    'Add Company',
                                    style: GoogleFonts.montserrat(),),
                                  content: Text('Do you want to add this Company',
                                      style: GoogleFonts.montserrat()),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.pop(buildcontext);
                                    },
                                        child: Text(
                                            'Cancel',
                                            style: GoogleFonts.montserrat())),
                                    TextButton(onPressed: () async {

                                      FirebaseFirestore.instance.collection('shops')
                                      .doc(currentshopId).update({
                                        'companies':FieldValue.arrayUnion([search.text.trim().toUpperCase()])
                                      });
                                      companyNames.add(search.text.trim().toUpperCase());


                                      showUploadMessage1(
                                          context, 'Company added successfully',
                                          style: GoogleFonts.montserrat());
                                      Navigator.pop(buildcontext);
                                      Navigator.pop(context,search.text);

                                      setState(() {

                                      });
                                    },
                                        child: const Text('Yes')),
                                  ],
                                );
                              });


                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 10,top: 20),
                          // height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFBFBFB),
                            //  color:Colors.red
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    // Container(
                                    //   height: 60,
                                    //   width: 70,
                                    //   // color: Colors.red,
                                    //   decoration: BoxDecoration(
                                    //       image: DecorationImage(image: CachedNetworkImageProvider(statement[index].image??''),fit: BoxFit.fill)
                                    //   ),
                                    // ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Text(statement[index].bookName,
                                        //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w800,fontSize: 20),),


                                        Text(search.text),

                                        // Text(statement[index].shopName??"",
                                        //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                        // const SizedBox(height: 5,),

                                        // Text(statement[index].bookName??"",
                                        //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                        // const SizedBox(height: 5,),



                                        // statement[index].noBook==true?
                                        // Text('No Book', style: GoogleFonts.montserrat(color:Colors.red,fontWeight: FontWeight.w800,fontSize: 14),):Container()


                                      ],
                                    )
                                  ],
                                ),
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     // statement[index].noBook==false?
                              //     Row(
                              //       children: [
                              //         Text(statement[index].currencyShort.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                              //         const SizedBox(width: 3,),
                              //         Text(statement[index].amount.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                              //       ],
                              //     ),
                              //
                              //
                              //
                              //   ],
                              // ),

                              // SizedBox(width: 5,),


                            ],
                          ),

                        ),
                      ),
                    ):
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: ()  {
                          Navigator.pop(context,companyNames.contains(search.text)?availableNames[index]:availableNames[index-1]);

                          },
                        child: Container(
                          padding: const EdgeInsets.only(right: 10,top: 20),
                          // height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFBFBFB),
                            //  color:Colors.red
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(statement[index].bookName,
                                      //   style:  GoogleFonts.montserrat(color:primarycolor1,fontWeight: FontWeight.w800,fontSize: 20),),

                                      Text(companyNames.contains(search.text)?availableNames[index]:availableNames[index-1]),

                                      // Text(statement[index].shopName??"",
                                      //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                      // const SizedBox(height: 5,),

                                      // Text(statement[index].bookName??"",
                                      //   style: TextStyle(color:Color(0xff5E5F5F),fontWeight: FontWeight.w700,fontSize: 14),),
                                      // const SizedBox(height: 5,),



                                      // statement[index].noBook==true?
                                      // Text('No Book', style: GoogleFonts.montserrat(color:Colors.red,fontWeight: FontWeight.w800,fontSize: 14),):Container()


                                    ],
                                  )
                                ],
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     // statement[index].noBook==false?
                              //     Row(
                              //       children: [
                              //         Text(statement[index].currencyShort.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId') ?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                              //         const SizedBox(width: 3,),
                              //         Text(statement[index].amount.toString(), style: GoogleFonts.montserrat(color:statement[index].toJson().containsKey('purchaseId')?Colors.black:Colors.green,fontWeight: FontWeight.w600,fontSize: 15),),
                              //       ],
                              //     ),
                              //
                              //
                              //
                              //   ],
                              // ),

                              // SizedBox(width: 5,),


                            ],
                          ),

                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel')),
        ),
      ],
    );
  }
}
