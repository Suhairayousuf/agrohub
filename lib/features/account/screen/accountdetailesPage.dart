import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/globals/local_variables.dart';
import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../Book/report/screen/companyList.dart';
import '../../Book/report/screen/company_report.dart';
import '../../Home/screen/homePage.dart';
import '../../Home/screen/selectShop.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/screen/authentication.dart';
import '../../auth/screen/login.dart';
import '../../auth/screen/splash.dart';
import '../../shopReports/purchase/screen/addPurchase.dart';
import '../../shopReports/purchase/screen/purchaseReport.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  void logout()async{
    userDataBox?.delete('email');
    ref.read(authControllerProvider.notifier).logout();
  }

  final Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),

      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            primarycolor1,
            primarycolor1,
          ])
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 1,
                height: width * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/appBar.png"),
                        fit: BoxFit.cover)),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.01,
                    ),

                    SizedBox(
                      width: width * 0.55,
                    ),

                  ],
                ),
              ),
              // Positioned(
              //   top: width * 0.3,
              //   height: width * 9,
              //   child:
                Container(
                  decoration: BoxDecoration(

                    color: Color(0xffF4F4F4),
                    borderRadius: BorderRadius.circular(32.11),
                  ),
                  width: width,
                  height: height*.8115,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(

                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10

                            ),

                          ),
                          child: Padding(
                            padding:  const EdgeInsets.only(left: 10,right: 10,top: 33),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                currentShopImage==''?
                                const CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/User Icon.jpg'),
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                ):InkWell(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPDFScreen()));
                                  },
                                  child: Container(
                                    height: 100,width: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          // color: Color(0xff848188)
                                            color: primarycolor1
                                        ),
                                        image: DecorationImage(
                                            image:  CachedNetworkImageProvider(currentShopImage),
                                            fit: BoxFit.fill
                                        )
                                    ),

                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Hello'.toUpperCase(),style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,fontSize: 14,
                                        color: primarycolor1
                                    ),),
                                    currentshopName==null?Text('USER',style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,fontSize: 14,color: primarycolor1
                                    )):Text(currentshopName!.toUpperCase(),style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,fontSize: 14,color:  primarycolor1
                                    ),),
                                    currentshopPhone==null?Container():Text('MOBILE : ${currentshopPhone!.toUpperCase()}',style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,fontSize: 12,color:  primarycolor1
                                    ),),
                                    currentshopId==null||currentshopId==null?Container():Text('SHOP ID : ${currentshopId!.toUpperCase()}',style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,fontSize: 12, color: primarycolor1
                                    ),),

                                    const SizedBox(height:15),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditWidget()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Card(
                              child: SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/person.svg"),
                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Text('Profile',style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                          color: primarycolor1

                                        ),),
                                      )),
                                      const Icon(Icons.arrow_forward_ios,size: 13,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                        InkWell(
                          onTap: (){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                builder: (context)=>SelectShopWidget(email: currentShopEmail,)), (route) => false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Card(
                              child: SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/switch.svg"),
                                      const SizedBox(width: 5,),


                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Text('Switch Shop',style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor1

                                        ),),
                                      )),
                                      const Icon(Icons.arrow_forward_ios,size: 13,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>const CompanyList()),);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Card(
                              child: SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/customers.svg"),
                                      const SizedBox(width: 5,),


                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Text('Company List',style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor1

                                        ),),
                                      )),
                                      const Icon(Icons.arrow_forward_ios,size: 13,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> SearchCompanyBook(appBarText: 'Company Report', isFromList: false,)),);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Card(
                              child: SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/customers.svg"),
                                      const SizedBox(width: 5,),


                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Text('Company Report',style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor1

                                        ),),
                                      )),
                                      const Icon(Icons.arrow_forward_ios,size: 13,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> Purchases()),);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Card(
                              child: SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/transaction.svg"),
                                      const SizedBox(width: 5,),


                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Text('Purchase',style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor1

                                        ),),
                                      )),
                                      const Icon(Icons.arrow_forward_ios,size: 13,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> PurchaseReport()),);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Card(
                              child: SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/transaction.svg"),
                                      const SizedBox(width: 5,),


                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Text('Purchase Report',style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor1

                                        ),),
                                      )),
                                      const Icon(Icons.arrow_forward_ios,size: 13,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Card(
                              child: SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/settings.svg"),
                                      const SizedBox(width: 5,),


                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Text('Settings',style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor1

                                        ),),
                                      )),
                                      const Icon(Icons.arrow_forward_ios,size: 13,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            showDialog(context: context,
                                builder: (buildContext)
                                {
                                  return AlertDialog(
                                    title:  Text('LogOut',style: GoogleFonts.montserrat(color: primarycolor2),),
                                    content:  Text('Do you want to logout?',style: GoogleFonts.montserrat(color: primarycolor2)),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(buildContext);
                                      },
                                          child:  Text('Cancel',style: GoogleFonts.montserrat(color: primarycolor2))),
                                      TextButton(onPressed: (){
                                        logout();
                                      // _auth.signOut(context);
                                        Navigator.pop(context);


                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login(),), (route) => false);
                                      },
                                          child:  Text('Yes',style: GoogleFonts.montserrat(color: primarycolor2))),
                                    ],
                                  );

                                });

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Card(
                              child: SizedBox(
                                height: 60,
                                child: Padding(
                                  padding:  const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/logout.svg"),
                                      const SizedBox(width: 5,),

                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Text('Logout',style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor1

                                        ),),
                                      )),
                                      const Icon(Icons.arrow_forward_ios,size: 13,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Text('version:5.6',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,fontSize: 8
                          ),),
                        const SizedBox(height: 80,),
                      ],
                    ),
                  ),
                ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
class EditWidget extends StatefulWidget {
  const EditWidget({Key ?key}) : super(key: key);

  @override
  _EditWidgetState createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {

  TextEditingController? name;
  TextEditingController? phone1;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: currentshopName);
    phone1 = TextEditingController(text:currentshopPhone);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Container(
              width: width * 1,
              height: width * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/appBar.png"),
                      fit: BoxFit.cover)),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.01,
                  ),

                  SizedBox(
                    width: width * 0.55,
                  ),

                ],
              ),
            ),
            Positioned(
              top: width * 0.3,
              // height: width * 9,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF4F4F4),
                  borderRadius: BorderRadius.circular(32.11),
                ),
                width: width,
                height: width * 5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 15,),
                      Text('Edit Profile',style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,fontSize: 18,color: primarycolor1

                      ),),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            currentShopImage==''?
                            const CircleAvatar(
                              backgroundImage: AssetImage('assets/images/User Icon.jpg'),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ):Container(
                              height: 100,width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    // color: Color(0xff848188)
                                      color: primarycolor1
                                  ),
                                  image: DecorationImage(
                                      image:  CachedNetworkImageProvider(currentShopImage),
                                      fit: BoxFit.fill
                                  )
                              ),

                            ),

                            const SizedBox(height: 15,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: name,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: GoogleFonts.montserrat(
                                    color: const Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,),
                                  hintText: 'Name',
                                  hintStyle: GoogleFonts.montserrat(
                                    color: const Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                                ),
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: phone1,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Official No',
                                  labelStyle: GoogleFonts.montserrat(
                                    color: const Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,),
                                  hintText: 'Enter your Official No...',
                                  hintStyle:GoogleFonts.montserrat(
                                    color: const Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                                ),
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFF1D2429),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  InkWell(
                                    onTap: () {
                                      if(name!.text!='' && phone1!.text!=''){
                                        FirebaseFirestore.instance.collection('users')
                                            .doc(currentshopId)
                                            .update({
                                          'storeName':name!.text,
                                          'phoneNumber':phone1!.text,
                                        });
                                        currentshopPhone=phone1!.text;
                                        currentshopName=name!.text;

                                        Navigator.pop(context);
                                        showUploadMessage1(context, 'Profile Updated...', style: GoogleFonts.montserrat());
                                        setState(() {

                                        });
                                      }else{
                                        name!.text==''?
                                        showUploadMessage1(context, 'Please Enter shop Name',  style: GoogleFonts.montserrat()):
                                        showUploadMessage1(context, 'Please Enter Phone Number', style: GoogleFonts.montserrat());
                                      }

                                    },
                                    child: Container(
                                      width: 130,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: primarycolor1,

                                        borderRadius: BorderRadius.circular(10,),
                                        border: Border.all(
                                          color: Colors.transparent,
                                          width: 1,

                                        ),


                                      ),
                                      child: Center(
                                        child: Text('Update', style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}