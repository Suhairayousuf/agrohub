import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../controller/customer_controller.dart';
import 'inactive_members.dart';
class Customer extends ConsumerStatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  ConsumerState<Customer> createState() => _CustomerState();
}

class _CustomerState extends ConsumerState<Customer> {
  // List <BookModel>customer = [];
  // List<BookModel> activeCustomer = [];
  // List <BookModel>inactiveCustomer = [];

  final customer = StateProvider((ref) => []);
  final activeCustomer = StateProvider((ref) => []);
  final inactiveCustomer = StateProvider((ref) => []);
  StreamSubscription? a;
  bool loading=true;
  getCustomers()  async {

      Future.delayed(Duration(microseconds: 1));
    ref.read(activeCustomer.notifier).state=  await ref.read(customerControllerProvider).getActiveCustomers();
    ref.read(inactiveCustomer.notifier).state= await ref.watch(customerControllerProvider).getInActiveCustomers();
    ref.read(customer.notifier).state=await ref.watch(customerControllerProvider).getCustomers();
    // print( ref.read(customer.notifier).state.length);

  }

  //   customer = [];
  //   activeCustomer = [];
  //   inactiveCustomer = [];
  //   for(var item in allBooks){
  //     customer.add(item);
  //     if(!item.block!){
  //       activeCustomer.add(item);
  //     }else{
  //       inactiveCustomer.add(item);
  //     }
  //   }
  //   loading=false;
  //   if(mounted){
  //     setState(() {});
  //   }
  // }
  // getCustomer() {
  //  a= FirebaseFirestore.instance
  //       .collection('shops')
  //       .doc(currentshopId)
  //       .collection('book').snapshots()
  //       .listen((value) async {
  //     customer = [];
  //     activeCustomer = [];
  //     inactiveCustomer = [];
  //
  //
  //     for (var abc in value.docs) {
  //       customer.addAll(abc.get("members"));
  //
  //       for (var a in abc.get('members')) {
  //         bookDataByUserId[a] = abc.data();
  //
  //       }
  //       if(abc.get('block')==false){
  //         for(var user in abc['members']){
  //           activeCustomer.add(user);
  //         }
  //
  //         //  activeCustomer=abc.get("members");
  //
  //       }else{
  //         for(var item in abc['members']){
  //           inactiveCustomer.add(item);
  //         }
  //
  //
  //       }
  //       //
  //       // customer.sort((a, b) => a.compareTo(b));
  //       customer.sort((a, b) {
  //         String name="";
  //         String name2="";
  //          FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: a).get().then((value) {
  //            if(value.docs.isNotEmpty){
  //              name=value.docs[0].get('userName');
  //            }
  //
  //         });
  //         FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: b).get().then((value) {
  //           if(value.docs.isNotEmpty){
  //             name2=value.docs[0].get('userName');
  //           }
  //
  //         });
  //         return name.compareTo(name2);
  //       });
  //
  //
  //     }
  //     loading=false;
  //     if (mounted) {
  //       setState(() {
  //
  //       });
  //     }
  //   });
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
  @override
  void initState() {
    //getCustomers();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    getCustomers();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    a?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        children: [
          AppBar("CUSTOMERS"),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 18.0,right: 18),
            child: Consumer(
              builder: (context,ref,child) {

                ref.watch(inactiveCustomer);
                ref.watch(activeCustomer);
                ref.watch(customer);                 return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: width*0.2,
                      width: width*0.25,
                      decoration:BoxDecoration(
                        // color: Color(0xffFF808B),
                          color: primarycolor1,
                          borderRadius: BorderRadius.circular(10)

                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Center(
                            child: Text('TOTAL ',style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),),
                          ),
                          SizedBox(height: 5,),
                          Center(
                            child: Text(ref.read(customer.notifier).state.length.toString(),style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: width*0.2,
                      width: width*0.25,
                      decoration:BoxDecoration(
                          color: primarycolor1,
                          borderRadius: BorderRadius.circular(10)

                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Center(
                            child: Text('ACTIVE',style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),),
                          ),
                          SizedBox(height: 5,),
                          Center(
                            child: Text(ref.read(activeCustomer.notifier).state.length.toString(),style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>InactiveMembersPage()));
                      },
                      child: Container(
                        height: width*0.2,
                        width: width*0.25,
                        decoration:BoxDecoration(
                            color: primarycolor1,
                            borderRadius: BorderRadius.circular(10)

                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text('INACTIVE',style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                            SizedBox(height: 5,),
                            Center(
                              child: Text(ref.read(inactiveCustomer.notifier).state.length.toString(),style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                );
              }
            ),
          ),
          // customer.length == 0
          //     ? Center(
          //   child: Container(
          //     child: Text(
          //       'No Customer Found',
          //       style: GoogleFonts.poppins(color: primarycolor2),
          //     ),
          //   ),
          // )
          //     :
          SizedBox(
            height: width * 0.03,
          ),
          Consumer(
            builder: (context,ref,child) {
              ref.watch(inactiveCustomer);
              ref.watch(activeCustomer);
              ref.watch(customer);
              return Expanded(
                // height: height * 0.782,
                child:ref.read(customer.notifier).state.length==0?Center(child: CircularProgressIndicator(),): ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: ref.read(activeCustomer.notifier).state.length,
                  itemBuilder: (context, index) {

                    // List data = customer[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Container(
                        // padding: EdgeInsets.only(left: 10, right: 10),
                        // height: height * 0.11,
                        width: width * 0.89,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              // shadow color
                              blurRadius: 15,
                              // shadow radius
                              offset: Offset(5, 10),
                              // shadow offset
                              spreadRadius: 0.4,
                              // The amount the box should be inflated prior to applying the blur
                              blurStyle: BlurStyle.normal, // set blur style
                            ),
                          ],
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(width*0.025),
                          child: Row(
                            children: [
                              Expanded(
                                child:ref.read(customer.notifier).state[index].members!.isEmpty?Container(): StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: ref.read(customer.notifier).state[index].members![0]).snapshots(),
                                  builder: (context, snapshot) {
                                    print(snapshot.data!.docs);
                                    print('1');
                                    if(!snapshot.hasData){

                                      return Center(child: CircularProgressIndicator());
                                    }
                                    if(snapshot.data!.docs.isEmpty){
                                      return Container();
                                    }
                                    return Text(
                                      "${snapshot.data!.docs[0].get('userName')}",
                                      // "${snapshot.data!.docs[0].get('userName')}",
                                      style: GoogleFonts.montserrat(
                                          fontSize: width * 0.04,
                                          color: primarycolor1,
                                          fontWeight: FontWeight.w600),
                                    );
                                  }
                                ),
                              ),
                              SizedBox(width: width*0.025,),
                              Text(
                                "Book Name: ${ref.read(customer.notifier).state[index].bookName}",
                                style: GoogleFonts.montserrat(
                                    fontSize: width * 0.04,
                                    color: primarycolor1,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
