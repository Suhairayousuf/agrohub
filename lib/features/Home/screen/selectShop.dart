
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upgrader/upgrader.dart';

import '../../../Model/OfferModel/offerModel.dart';
import '../../../Model/bookModel.dart';
import '../../../core/globals/local_variables.dart';
import '../../../core/utils/utils.dart';
import '../../../model/shop_model/shop_model.dart';
import '../../../themes/color.dart';

import '../../auth/controller/auth_controller.dart';
import '../../auth/screen/authentication.dart';
import '../../auth/screen/login.dart';
import '../../auth/screen/splash.dart';
import '../controller/home_controller.dart';
import 'NavigationBar.dart';
String ?currentUserName;

String? currentshopId;
String? currentshopName;
String? currentshopPhone;
double? currentshopCredit;
DateTime? currentshopPlanEnd;
String ? currencyCode;
String ? isoCode;
List <OfferModel>offer=[];
List <BookModel>bookList=[];
List companyNames=[];

class SelectShopWidget extends ConsumerStatefulWidget {
  final String? email;
  const SelectShopWidget({Key? key, required this.email, }) : super(key: key);

  @override
  _SelectShopWidgetState createState() => _SelectShopWidgetState();
}

class _SelectShopWidgetState extends ConsumerState<SelectShopWidget> {

  var data;
  List<StoreDetailsModel> datas=[];
bool multiple=false;
  var branch;
  bool loading=true;
  getShop() async {
    // QuerySnapshot value=await FirebaseFirestore.instance
    //     .collection('shops')
    //     .where('shopAdmins', arrayContains: widget.email)
    //     .get();

    List<StoreDetailsModel> shopData=await ref.read(getHomeStreamProvider(widget.email??"").future);

      // data = value.docs.length;
      // data = value.docs.length;

      datas = shopData;
      if (shopData.length == 1) {
        print('object');
        ref.read(getShopOffersProvider(shopData.first.shopId!).future).then((value) {
          offer=[];

          for(var off in value){

            offer.add(off);
          }
        });

        // value.docs[0].reference.collection('offers').get().then((event) {
        //   offer=[];
        //
        //   for(var off in event.docs){
        //     offer.add(OfferModel.fromJson(off.data()!));
        //   }
        //
        //
        // });
        //value.docs[0].reference.collection('book').where('delete',isEqualTo: false).get().then((event) {
        ref.read(getShopBooksProvider(shopData.first.shopId!).future).then((event) {

          bookList=[];

          for(var abc in event){
            bookList.add(abc);
          }

        });
        currentshopId = datas[0].shopId;
        currentshopName = datas[0].storeName;
        currentShopImage = datas[0].shopImage!;
        currentshopPhone = datas[0].phoneNumber;
        currentshopCredit =double.tryParse( datas[0].totalCredit.toString());
        currentshopPlanEnd =datas[0].pEnd;
        currencyCode=datas[0].currencyShort;
        isoCode=datas[0].isoCode;

        try {
          companyNames=datas[0].companies??[];
        } catch (e) {
          companyNames=[];
        }

        if(mounted) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => NavBarPage()), (
                  route) => false);
        }
        // await Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => NavigationBarPage()));


      }
      else{

        // CircularProgressIndicator();
      }
      loading=false;
      if(mounted) {
        setState(() {
          data = shopData.length;
          datas = shopData;

        });
      }


  }
  @override
  void initState() {

    getShop();

    super.initState();

  }
  @override
  void dispose() {

    super.dispose();
  }
  void logout()async{
    userDataBox?.delete('email');
    ref.read(authControllerProvider.notifier).logout();
  }
  final Authentication _auth = Authentication();
  @override
  Widget build(BuildContext context) {


    return UpgradeAlert(
      child: Scaffold(
        backgroundColor: primarycolor1,
        body:loading?Center(child: CircularProgressIndicator(),): datas.length==0? Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Center(child: Text('No Shops Found',style: GoogleFonts.montserrat(
              color: Colors.white
            ),)),
            SizedBox(
              height: MediaQuery.of(context).size.height*.08,
              child: InkWell(
                  onTap: ()async {

                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title:  Text("Log Out",style:GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight:FontWeight.w600,
                            color: primarycolor1),),
                        content:  Text("Are you Sure ?",style:GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight:FontWeight.w600,
                            color: primarycolor1),),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width:75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 2,color: primarycolor1),

                                    ),
                                    child: Center(
                                      child: Text('No',style:GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight:FontWeight.w600,
                                          color: primarycolor1),),
                                    ),
                                  )),
                              InkWell(
                                  onTap: () async {

                                    // await _auth.signOut(context);
                                    await  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                                    const Login()), (route) => false);
                                  },
                                  child: Container(
                                    height: 40,
                                    width:75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 2,color: primarycolor1),

                                    ),
                                    child: Center(
                                      child: Text('Yes',style:GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight:FontWeight.w600,
                                          color: primarycolor1),),
                                    ),
                                  )),
                            ],
                          ),

                        ],),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                        height: width*0.3,
                        width: width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primarycolor1
                        ),
                        child: Center(child: Text('Log out',style: GoogleFonts.montserrat(
                            color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        ))),
                  )),
            ),
          ],
        ):
        (datas.length>1)
        ? Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: primarycolor1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.05
                    ,),
                  Center(
                    child: Text('Shops',style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .095,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width*1.86,
                decoration: BoxDecoration(
                  // image: const DecorationImage(
                  //     image: AssetImage('assets/images/Background.jpg'),
                  //     fit: BoxFit.fill),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: primarycolor1,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                    ),
                    shrinkWrap: true,
                    itemCount: datas.length,
                    itemBuilder: ( context,  index) {
                      return InkWell(
                        onTap: () async {
                          FirebaseFirestore.instance.collection('shops').
                          doc( datas[index].shopId).collection('offers').get().then((value) {

                            offer=[];
                            for(var off in value.docs){
                              offer.add(OfferModel.fromJson(off.data()!));
                            }

                                          setState(() {

                                          });
                          });

                          FirebaseFirestore.instance.collection('shops').
                          doc( datas[index].shopId).collection('book').get().then((abc) {
                            bookList=[];

                            for(var cd in abc.docs){
                              bookList.add(BookModel.fromJson(cd.data()!));

                            }

                              setState(() {

                              });


                          });

                          currentshopId = datas[index].shopId;
                          currentshopName = datas[index].storeName;
                          currentShopImage = datas[index].shopImage.toString();
                          currentshopPhone = datas[index].phoneNumber;
                          currentshopCredit =double.tryParse( datas[index].totalCredit.toString());
                          currentshopPlanEnd =datas[index].pEnd;
                          currencyCode=datas[index].currencyShort;
                          isoCode=datas[index].isoCode;

                          try {
                            companyNames=datas[index].companies??[];
                          } catch (e) {
                            companyNames=[];
                          }

                          Navigator.push(context,MaterialPageRoute(builder: (context)=>const NavBarPage()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*.3,
                          width: MediaQuery.of(context).size.width*.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xffEAEAEA),width: 2),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(datas[index].shopImage.toString(),
                                      ),
                                      fit:BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*.43,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primarycolor1
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(datas[index].storeName.toString(),maxLines: 2,textAlign: TextAlign.center,style: GoogleFonts.montserrat(
                                        fontSize: width*.033,color: Colors.white,fontWeight: FontWeight.w600),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        )
            :const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}