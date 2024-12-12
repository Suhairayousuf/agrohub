import 'dart:async';
import 'dart:io';
import 'package:agrohub/features/Book/member/popUp/companyName.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_currency_pickers/currency_picker_dialog.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:searchfield/searchfield.dart';

import 'package:country_state_city/country_state_city.dart' as csc;



import '../../../../Model/usermodel/user_model.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/NavigationBar.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';
import 'addoffline_members2.dart';
List userDetails=[1,2];
class EditMember extends StatefulWidget {
  final UserModel userData;
  final List bookMembers;
  final String shopId;
  final String bookId;
  const EditMember({Key? key, required this.userData, required this.bookMembers, required this.shopId, required this.bookId}) : super(key: key);

  @override
  State<EditMember> createState() => _EditMemberState();
}

class _EditMemberState extends State<EditMember> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _whatsappNumberController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  TextEditingController _icamaController = TextEditingController();
  TextEditingController _companynameController = TextEditingController();
  TextEditingController _cabnameController = TextEditingController();
  TextEditingController _doornumberController = TextEditingController();
  TextEditingController city = TextEditingController();
  // TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
   TextEditingController countryController=TextEditingController();
   TextEditingController currencyController=TextEditingController();

  String? countryValue;
  String? existId='';
  String countryShortName = 'IN';
  String? stateValue;
  String? cityValue;
  List<csc.Country>? countries;
  List<String> countriesList = [''];
  Map<String, csc.Country> countryData = {};
  String countryIso = '';

  List<csc.State>? states;
  List<String> statesList = [''];
  Map<String, csc.State> stateData = {};
  String stateIso = '';

  bool read = false;
  String url = '';
  String currency='';
  String countryCode='';
  String phonePrefix='';


  List<csc.City>? cities;
  List<String> citiesList = [''];
  bool loading = false;

  String ?_email;

  // FormFieldValidator<String> emailValidator = (value) {
  //   RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
  //
  //   if (value!.isEmpty) {
  //     return 'Please enter an email address';
  //   }
  //   if (!emailRegex.hasMatch(value)) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
  // };

  showCurrencyPickerDialog() {

    showDialog(
      context: context,
      builder: (context) => CurrencyPickerDialog(
        titlePadding: EdgeInsets.all(8.0),
        searchCursorColor: Colors.white,
        searchInputDecoration: InputDecoration(
            hintText: 'Search Currency',
            hintStyle: GoogleFonts.montserrat(
                color: Colors.white
            )
        ),
        isSearchable: true,
        title: Text('Select your currency',style: TextStyle(
            color: Colors.white
        ),),
        // onValuePicked: ((Currency currency) => setState(() {
        //   _selectedCurrency = currency;
        // })),

        onValuePicked: (value) {

          countryCode=value.isoCode!;
          currency=value.currencyCode!;
          currencyController!.text=value.currencyName!;
          countryController.text=value.name!;
          setState(() {

          });
        },

        // showFlag: true,
        // showCurrencyName: true,
        // showCurrencyCode: true,
      ),
    );
  }
  refreshPage() {
    setState(() {
      loading = false;
    });
  }

  List _images = [];
  List _imgurl = [];
  String? imgUrl;
  var imgFile;
  var uploadTask;
  var fileUrl;
  var docUrl;
  var uploadTasks;

  Future uploadImageToFirebase(BuildContext context) async {
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('deposits/${imgFile.path}');
    UploadTask uploadTask = firebaseStorageRef.putFile(imgFile);
    TaskSnapshot taskSnapshot = (await uploadTask);
    String value = await taskSnapshot.ref.getDownloadURL();

    // if(value!=null){
    //   imageList.add(value);
    // }
    setState(() {
      loading = false;
      _imgurl.add(value);

      imgUrl = value;


    });
  }

  _pickImage() async {
    loading = true;

    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.camera);
    setState(() {
      imgFile = File(imageFile!.path);
      _images.add(File(imgFile!.path));

      uploadImageToFirebase(context);
      showUploadMessage1(context, 'Uploading', showLoading: true, style:GoogleFonts.montserrat());
    });
  }

  _pickImages() async {
    loading = true;

    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      _images.add(File(imgFile!.path));

      uploadImageToFirebase(context);
    });
  }
  final _formKey = GlobalKey<FormState>();
  getCountry() async {
    countries = await csc.getAllCountries();
    countriesList = [];
    citiesList = [''];
    for (var a in countries!) {
      countriesList.add(a.name);
      countryData[a.name] = a;
    }

    // getData();
    if (mounted) {
      setState(() {});
    }
  }

  getStates(var iso) async {
    states = await csc.getStatesOfCountry(iso);
    statesList = states!.isEmpty ? [''] : [];
    citiesList = [''];
    stateData = {};
    for (var a in states!) {
      statesList.add(a.name);
      stateData[a.name] = a;
    }

    if (mounted) {
      setState(() {});
    }
  }

  getCities(var countryIso, var stateIso) async {
    cities = await csc.getStateCities(countryIso, stateIso);
    citiesList = cities!.isEmpty ? [''] : [];
    // city.clear();
    for (var a in cities!) {
      citiesList.add(a.name);
    }

    if (mounted) {
      setState(() {});
    }
  }

  String? dropdownvalue1;
  var item1 = ['1', '2', '3'];

  String? dropdownvalue2;
  var item2 = ['A', 'B', 'C'];
  String selectedEmail='';
  @override
  void initState() {
     _namecontroller = TextEditingController(text: widget.userData.userName);
     _emailcontroller = TextEditingController(text: widget.userData.userEmail);
     _phoneController = TextEditingController(text: widget.userData.phone);
     _whatsappNumberController = TextEditingController(text: widget.userData.whatsappNumber);
     jobController = TextEditingController(text: widget.userData.jobNumber);
     // _confirmPassController = TextEditingController();
     // _icamaController = TextEditingController();
     _companynameController = TextEditingController(text: widget.userData.companyName);
     _cabnameController = TextEditingController(text: widget.userData.cabName);
     _doornumberController = TextEditingController(text: widget.userData.doorNumber);
     // city = TextEditingController(text: widget.userData.userName);
    // TextEditingController country = TextEditingController();
    // state = TextEditingController(text: widget.userData.);
     countryController=TextEditingController(text: widget.userData.country);
    currencyController=TextEditingController(text: widget.userData.currencyShort);
    imgUrl=widget.userData.userImage??"";
     countryCode=widget.userData.countryCode??"";
     phonePrefix=widget.userData.phonePrefix??"";

     // _emailcontroller.addListener(() {
    //   if (_emailcontroller.text.isEmpty && selectedEmail.isNotEmpty) {
    //     selectedEmail = '';
    //     _namecontroller.clear();
    //     _phoneController.clear();
    //     _companynameController.clear();
    //     _cabnameController.clear();
    //     _doornumberController.clear();
    //     countryController.clear();
    //     currencyController.clear();
    //     countryCode = '';
    //     // updatedId = '';
    //     existId = '';
    //     imgUrl = '';
    //     // isOffline = false;
    //
    //     setState(() {});
    //   }
    // });
     getUsers();
    super.initState();
  }
  StreamSubscription? a;
  getUsers(){
    a=FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      userEmailList=[];
      for(var data in value.docs){
        userEmailList.add(data.get('userEmail'));
        userMap[data.get('userEmail')]=data.data();
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }
  int suggestionsCount = 12;
  final focus = FocusNode();
  @override
  void dispose() {
    a?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: primarycolor1,
        body: SingleChildScrollView(
          child: Container(
            // height: width * 2.1,
            width: double.infinity,
            padding: EdgeInsets.all(width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: width * 0.07),
                Text(
                  "Welcome",
                  style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffF8F7F7)),
                ),

                SizedBox(
                  height: width * 0.05,
                ),
                Center(
                  child: badges.Badge(
                    badgeContent: InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Container(
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.photo_library),
                                      title: Text('Photo Library'),
                                      onTap: () {
                                        _pickImages();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Camera'),
                                      onTap: () {
                                        _pickImage();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                          height: height * 0.035,
                          width: width * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            color:primarycolor1,
                            size: 19,
                          )),
                    ),
                    badgeStyle: BadgeStyle(
                        badgeColor: primarycolor1
                    ),
                    // badgeColor: Colors.white,
                    // position: BadgePosition(start:5 ),
                    child: GestureDetector(
                      onTap: (() {
                        // showModalBottomSheet(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return SafeArea(
                        //       child: Container(
                        //         child: Wrap(
                        //           children: [
                        //             ListTile(
                        //               leading: Icon(Icons.photo_library),
                        //               title: Text('Photo Library'),
                        //               onTap: () {
                        //                 _pickImages();
                        //                 Navigator.of(context).pop();
                        //               },
                        //             ),
                        //             ListTile(
                        //               leading: Icon(Icons.camera_alt),
                        //               title: Text('Camera'),
                        //               onTap: () {
                        //                 _pickImage();
                        //                 Navigator.of(context).pop();
                        //               },
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // );
                        // _pickImages();
                      }),
                      child: CircleAvatar(
                        radius: 46,
                        backgroundImage: imgUrl == ''
                            ? CachedNetworkImageProvider(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1VtVwnOHAemy39L0SnoUtvpYsAP83Jr_bFA&usqp=CAU",
                        )
                            // : FileImage(imgFile!) as ImageProvider,
                            : CachedNetworkImageProvider(imgUrl! ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: width * 0.05,
                ),

                SizedBox(
                  height: width * 0.15,
                  child: TextFormField(
                    // autovalidateMode: AutovalidateMode.always,
                      controller: _namecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'User name',
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter your user name...',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: primarycolor1,
                        contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                      ),
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                SizedBox(
                  height: width * 0.025,
                ),
                // SizedBox(
                //   height: width * 0.05,
                // ),
                // SizedBox(
                //   height: width * 0.1,
                //   child: Form(
                //     key: _formKey,
                //     child: SearchField(
                //
                //         // _validateEmail
                //       // validator: (value){
                //       //
                //       //   RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
                //       //
                //       //   if (value!.isEmpty) {
                //       //     return 'Please enter an email address';
                //       //   }
                //       //   if (!emailRegex.hasMatch(value)) {
                //       //     return 'Please enter a valid email address';
                //       //   }
                //       //   return null;
                //       // },
                //
                //       // validator: (email) {
                //       //   if (email!.isEmpty) {
                //       //     return "";
                //       //   } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                //       //       .hasMatch(email)) {
                //       //     return "Email not valid";
                //       //   } else {
                //       //     return null;
                //       //   }
                //       // },
                //
                //       suggestions:userEmailList,
                //       controller:  _emailcontroller,
                //       hint: 'Please Enter ID number',
                //       searchStyle: GoogleFonts.montserrat(
                //         fontSize: 14,
                //         color: Colors.white,
                //         fontWeight: FontWeight.normal,
                //
                //       ),
                //       searchInputDecoration: InputDecoration(
                //         labelText: 'ID number',
                //         labelStyle: GoogleFonts.poppins(
                //           color: Colors.white,
                //           fontSize: 14,
                //           fontWeight: FontWeight.normal,
                //         ),
                //         hintText: 'Enter your ID number...',
                //         hintStyle: GoogleFonts.poppins(
                //           color: Colors.white,
                //           fontSize: 14,
                //           fontWeight: FontWeight.normal,
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.white,
                //             width: 1,
                //           ),
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.white,
                //             width: 1,
                //           ),
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         filled: true,
                //         fillColor: primarycolor1,
                //         contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                //       ),
                //
                //       onTap: (x) {
                //         _email = x;
                //         _namecontroller.text=userMap[x]['userName'];
                //         _phoneController.text=userMap[x]['phone'];
                //         // _icamaController.text=userMap[x]['icamaNumber'];
                //         _companynameController.text=userMap[x]['companyName'];
                //         _cabnameController.text=userMap[x]['cabName'];
                //         _doornumberController.text=userMap[x]['doorNumber'];
                //         countryController.text=userMap[x]['country'];
                //         currencyController.text=userMap[x]['currencyShort'];
                //         // existId=alluserMap[x]['userId'];
                //          existId=userMap[x]['userEmail']??"";
                //          imgUrl=userMap[x]['userImage']??"";
                //
                //          // _imgurl=userMap[x]['cardImage'];
                //          //  _images=userMap[x]['cardImage'];
                //          //  print(_imgurl.length);
                //        // for(var data in userMap[x]['cardImage']) {
                //        //   _imgurl.add(data);
                //        // }
                //         setState(() {
                //
                //         });
                //       },
                //     ),
                //   ),
                //
                // ),
                RawAutocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    print('textEditingValue.text');
                    print(textEditingValue.text);
                    print(textEditingValue.text.length);
                    if (textEditingValue.text == '' || textEditingValue.text.length<4) {
                      return const Iterable<String>.empty();
                    }else {

                      List<String> matches = <String>[];
                      matches.addAll(userEmailList);

                      matches.retainWhere((s){
                        return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                      return matches;
                    }
                  },
                  initialValue: TextEditingValue(text: _emailcontroller.text),
                  onSelected: (String x) {
                     // FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: x.toString()).get().then((value){
                       selectedEmail=x.toString();
                       _namecontroller.text=userMap[x]['userName'];
                       _phoneController.text=userMap[x]['phone'];
                       // _icamaController.text=userMap[x.searchKey]['icamaNumber'];
                       _companynameController.text=userMap[x]['companyName'];
                       _cabnameController.text=userMap[x]['cabName'];
                       _doornumberController.text=userMap[x]['doorNumber'];
                       countryController.text=userMap[x]['country'];
                       currencyController.text=userMap[x]['currencyShort'];
                       // existId=alluserMap[x]['userId'];
                       existId=userMap[x]['userEmail']??"";
                       imgUrl=userMap[x]['userImage']??"";
                       _emailcontroller.text=userMap[x]['userEmail']??"";


                    // initialLength=userMap[x]['phone'].length??8;
                    // initialCountryCode=userMap[x]['countryCode']??"QA";
                    // _imgurl=userMap[x]['cardImage'];
                    //  _images=userMap[x]['cardImage'];
                    //  print(_imgurl.length);
                    // for(var data in userMap[x]['cardImage']) {
                    //   _imgurl.add(data);
                    // }
                    // readOnly=true;
                    setState(() {

                    });
                  },

                  fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(

                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        labelText: 'ID Number',
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter ID number',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: primarycolor1,
                        contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                      ),
                      controller: textEditingController,
                      focusNode: focusNode,
                      onChanged:(value) {

                        _emailcontroller.text=value;
                        setState(() {

                        });
                      },
                      onSubmitted: (x) {
                        // FirebaseFirestore.instance.collection('users').where('userEmail',isEqualTo: x.toString()).get().then((value) {
                          selectedEmail=x.toString();
                          _namecontroller.text=userMap[x]['userName'];
                          _phoneController.text=userMap[x]['phone'];
                          // _icamaController.text=userMap[x.searchKey]['icamaNumber'];
                          _companynameController.text=userMap[x]['companyName'];
                          _cabnameController.text=userMap[x]['cabName'];
                          _doornumberController.text=userMap[x]['doorNumber'];
                          countryController.text=userMap[x]['country'];
                          currencyController.text=userMap[x]['currencyShort'];
                          // existId=alluserMap[x]['userId'];
                          existId=userMap[x]['userEmail']??"";
                          imgUrl=userMap[x]['userImage']??"";
                          _emailcontroller.text=userMap[x]['userEmail']??"";
                        // });
                        // selectedEmail=x.toString();
                        // _namecontroller.text=userMap[x]['userName'];
                        // _phoneController.text=userMap[x]['phone'];
                        // // _icamaController.text=userMap[x.searchKey]['icamaNumber'];
                        // _companynameController.text=userMap[x]['companyName'];
                        // _cabnameController.text=userMap[x]['cabName'];
                        // _doornumberController.text=userMap[x]['doorNumber'];
                        // countryController.text=userMap[x]['country'];
                        // currencyController.text=userMap[x]['currencyShort'];
                        // // existId=alluserMap[x]['userId'];
                        // existId=userMap[x]['userEmail']??"";
                        // imgUrl=userMap[x]['userImage']??"";
                        // _emailcontroller.text=userMap[x]['userEmail']??"";
                        // // initialLength=userMap[x]['phone'].length??8;
                        // // initialCountryCode=userMap[x]['countryCode']??"QA";
                        // // _imgurl=userMap[x]['cardImage'];
                        // //  _images=userMap[x]['cardImage'];
                        // //  print(_imgurl.length);
                        // // for(var data in userMap[x]['cardImage']) {
                        // //   _imgurl.add(data);
                        // // }
                        // // readOnly=true;
                        setState(() {

                        });
                      },
                    );
                  },

                  optionsViewBuilder: (BuildContext context, void Function(String) onSelected,
                      Iterable<String> options) {
                    return Material(
                        child:SizedBox(
                          // height: 200,
                            child:ListView(
                              shrinkWrap: true,
                              children: options.map((opt){
                                return InkWell(
                                    onTap: (){
                                      onSelected(opt);
                                    },
                                    child:Container(
                                        padding: EdgeInsets.only(right:60),
                                        child:Card(
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10),
                                              child:Text(opt),
                                            )
                                        )
                                    )
                                );
                              }).toList(),
                            )
                        )
                    );
                  },
                ),
                // Form(
                //   key: _formKey,
                //   child: SearchField(
                //     controller: _emailcontroller,
                //
                //     onSearchTextChanged: (value){
                //       existId='';
                //       setState(() {
                //         _formKey.currentState!.validate();
                //       });
                //
                //     },
                //
                //     suggestions: userEmailList
                //         .map((e) => SearchFieldListItem(e,
                //         child: Align(
                //           alignment: Alignment.centerLeft,
                //           child: Text(
                //             e,
                //             style: TextStyle(color: Colors.black),
                //           ),
                //         )))
                //         .toList(),
                //     suggestionState: Suggestion.expand,
                //     textInputAction: TextInputAction.next,
                //     hint: 'Please Enter  Id No',
                //     searchStyle: TextStyle(
                //       fontSize: 18,
                //       color: Colors.black.withOpacity(0.8),
                //     ),
                //     // validator: (x) {
                //     //   RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
                //     //
                //     //   if (x!.isEmpty) {
                //     //     return 'Please enter an email address';
                //     //   }
                //     //   if (!emailRegex.hasMatch(x)) {
                //     //     return 'Please enter a valid email address';
                //     //   }
                //     //   return null;
                //     // },
                //     searchInputDecoration: InputDecoration(
                //       labelText: 'ID Number',
                //       labelStyle: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       ),
                //       hintText: 'Enter your ID Number...',
                //       hintStyle: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //           width: 1,
                //         ),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //           width: 1,
                //         ),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       filled: true,
                //       fillColor: primarycolor1,
                //       contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                //     ),
                //     maxSuggestionsInViewPort: 6,
                //     itemHeight: 50,
                //     onSuggestionTap: (x) {
                //       selectedEmail=x.toString();
                //       print('x');
                //       print(x.searchKey);
                //       print(userMap[x]);
                //       _namecontroller.text=userMap[x.searchKey]['userName'];
                //       _phoneController.text=userMap[x.searchKey]['phone'];
                //       // _icamaController.text=userMap[x.searchKey]['icamaNumber'];
                //       _companynameController.text=userMap[x.searchKey]['companyName'];
                //       _cabnameController.text=userMap[x.searchKey]['cabName'];
                //       _doornumberController.text=userMap[x.searchKey]['doorNumber'];
                //       countryController.text=userMap[x.searchKey]['country'];
                //       currencyController.text=userMap[x.searchKey]['currencyShort'];
                //       // existId=alluserMap[x]['userId'];
                //       existId=userMap[x.searchKey]['userEmail']??"";
                //       imgUrl=userMap[x.searchKey]['userImage']??"";
                //
                //       // _imgurl=userMap[x]['cardImage'];
                //       //  _images=userMap[x]['cardImage'];
                //       //  print(_imgurl.length);
                //       // for(var data in userMap[x]['cardImage']) {
                //       //   _imgurl.add(data);
                //       // }
                //       setState(() {
                //
                //       });
                //     },
                //   ),
                // ),
                // TextFormField(
                //     keyboardType: TextInputType.emailAddress,
                //     // autovalidateMode: AutovalidateMode.always,
                //     controller: _emailcontroller,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Please enter your email address';
                //       }
                //
                //       final emailRegex =
                //       RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                //       if (!emailRegex.hasMatch(value)) {
                //         return 'Please enter a valid email address';
                //       }
                //       return null;
                //     },
                //     obscureText: false,
                //     decoration: InputDecoration(
                //       labelText: 'Email',
                //       labelStyle: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       ),
                //       hintText: 'Enter your email address...',
                //       hintStyle: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //           width: 1,
                //         ),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //           width: 1,
                //         ),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       filled: true,
                //       fillColor: primarycolor1,
                //       contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                //     ),
                //     style: GoogleFonts.poppins(
                //       color: Colors.white,
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal,
                //     )),
                SizedBox(
                  height: width * 0.025,
                ),
                SizedBox(


                  child: IntlPhoneField(
                    style: TextStyle(color: Colors.white),
                    dropdownTextStyle: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      iconColor: Colors.white,
                      counterStyle: TextStyle(color: Colors.white),
                      hintText: 'Enter your phone number...',
                      hintStyle: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      labelText: 'Phone Number',
                      labelStyle: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),

                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    initialCountryCode: countryCode,
                    dropdownIcon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                    onChanged: (phone) {

                      countryCode = phone.countryISOCode;
                      // _phoneNumber.text = phone.completeNumber;

                    },
                    onCountryChanged: (country) {


                      // countryCode = '+${country.dialCode}';
                    },
                  ),


                ),
                SizedBox(
                  height: width * 0.025,
                ),
                SizedBox(


                  child: IntlPhoneField(
                    style: TextStyle(color: Colors.white),
                    dropdownTextStyle: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      iconColor: Colors.white,
                      counterStyle: TextStyle(color: Colors.white),
                      hintText: 'Enter your whatsapp number...',
                      hintStyle: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      labelText: 'WhatsApp Number',
                      labelStyle: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),

                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    initialCountryCode: countryCode,
                    dropdownIcon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                    onChanged: (phone) {

                      countryCode = phone.countryISOCode;
                      // _phoneNumber.text = phone.completeNumber;

                    },
                    onCountryChanged: (country) {



                       countryCode = '+${country.dialCode}';
                    },
                  ),


                ),

                SizedBox(
                  height: width * 0.025,
                ),
                // SizedBox(
                //   height: width * 0.15,
                //   child: TextFormField(
                //     // autovalidateMode: AutovalidateMode.always,
                //       controller: _phoneController,
                //       obscureText: false,
                //       keyboardType: TextInputType.number,
                //       decoration: InputDecoration(
                //         labelText: 'Phone No',
                //         labelStyle: GoogleFonts.poppins(
                //           color: Colors.white,
                //           fontSize: 14,
                //           fontWeight: FontWeight.normal,
                //         ),
                //         hintText: 'Enter your phone number...',
                //         hintStyle: GoogleFonts.poppins(
                //           color: Colors.white,
                //           fontSize: 14,
                //           fontWeight: FontWeight.normal,
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.white,
                //             width: 1,
                //           ),
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.white,
                //             width: 1,
                //           ),
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         filled: true,
                //         fillColor: primarycolor1,
                //         contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                //       ),
                //       style: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       )),
                // ),
                // SizedBox(
                //   height: width * 0.0,
                // ),
                // SizedBox(
                //   height: width * 0.15,
                //   child: TextFormField(
                //     // autovalidateMode: AutovalidateMode.always,
                //       controller: _icamaController,
                //       obscureText: false,
                //       decoration: InputDecoration(
                //         labelText: 'ID No',
                //         labelStyle: GoogleFonts.poppins(
                //           color: Colors.white,
                //           fontSize: 14,
                //           fontWeight: FontWeight.normal,
                //         ),
                //         hintText: 'Enter your ID No...',
                //         hintStyle: GoogleFonts.poppins(
                //           color: Colors.white,
                //           fontSize: 14,
                //           fontWeight: FontWeight.normal,
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.white,
                //             width: 1,
                //           ),
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.white,
                //             width: 1,
                //           ),
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         filled: true,
                //         fillColor: primarycolor1,
                //         contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                //       ),
                //       style: GoogleFonts.poppins(
                //         color: Colors.white,
                //         fontSize: 14,
                //         fontWeight: FontWeight.normal,
                //       )),
                // ),
                // SizedBox(
                //   height: width * 0.05,
                // ),
                ///
                SizedBox(
                  height: width * 0.15,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _companynameController,
                      readOnly: true,
                      obscureText: false,
                      onTap: () async {
                        String a=_companynameController.text;
                        dynamic d=await showDialog(context: context,
                            builder: (buildcontext) {
                              return SelectCompanyName(t: _companynameController.text,);
                            });

                        _companynameController.text=d ?? a;
                      },

                      decoration: InputDecoration(
                        labelText: 'Company name',
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter your company name...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: primarycolor1,
                        contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                      ),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ))
                ),

                SizedBox(
                  height: width * 0.025,
                ),
                // SizedBox(
                //   height: width * 0.05,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       height: width * 0.15,
                //       width: width * 0.4,
                //       padding: EdgeInsets.only(
                //           left: width * 0.03, right: width * 0.03),
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8),
                //           border: Border.all(width: 1, color: Colors.white)),
                //       child:TextFormField(
                //         decoration: InputDecoration(
                //
                //           suffixIcon: IconButton(
                //             onPressed: showCurrencyPickerDialog,
                //             icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                //           ),
                //           labelText: 'Country',
                //           labelStyle: GoogleFonts.montserrat(
                //             color: Colors.white,
                //             fontWeight: FontWeight
                //                 .w500,
                //             fontSize: 14
                //           ),
                //           hintText:
                //           'Country',
                //           hintStyle:  GoogleFonts.montserrat(
                //
                //             color: primarycolor1,
                //             fontWeight: FontWeight
                //                 .w500,
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //
                //             borderSide: BorderSide(
                //               color: primarycolor1,
                //
                //             ),
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderSide: BorderSide(
                //               color:  primarycolor1,
                //
                //             ),
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           filled: true,
                //           fillColor:primarycolor1
                //         ),
                //         readOnly: true,
                //         controller: countryController,
                //       ),
                //     ),
                //     Container(
                //       height: width * 0.15,
                //       width: width * 0.4,
                //       padding: EdgeInsets.only(
                //           left: width * 0.03, right: width * 0.03),
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8),
                //           border: Border.all(width: 1, color: Colors.white)),
                //       child:TextFormField(
                //         decoration: InputDecoration(
                //           labelText: 'Currency',
                //           labelStyle: GoogleFonts.montserrat(
                //             color: Colors.white,
                //             fontWeight: FontWeight
                //                 .w500,
                //             fontSize: 14
                //           ),
                //           hintText:
                //           'Currency',
                //           hintStyle: GoogleFonts.montserrat(
                //
                //             color: Colors.white,
                //             fontWeight: FontWeight
                //                 .w500,
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderSide: BorderSide(
                //               color: primarycolor1,
                //
                //             ),
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderSide: BorderSide(
                //               color:  primarycolor1,
                //
                //             ),
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           filled: true,
                //           fillColor: primarycolor1
                //         ),
                //
                //         readOnly: true,
                //         controller: currencyController,
                //       ),
                //       // DropdownButton(
                //       //   underline: Container(),
                //       //   hint: Text('city',
                //       //       style: GoogleFonts.poppins(
                //       //           color: Colors.white,
                //       //           fontSize: 14,
                //       //           fontWeight: FontWeight.w400)),
                //       //   value: dropdownvalue2,
                //       //   dropdownColor: Colors.blueGrey[300],
                //       //   icon: Icon(
                //       //     Icons.keyboard_arrow_down_sharp,
                //       //     color: Colors.white,
                //       //   ),
                //       //   iconDisabledColor: Colors.grey[100],
                //       //   items: item2.map((String items) {
                //       //     return DropdownMenuItem(
                //       //       value: items,
                //       //       child: Center(
                //       //         child: Text(
                //       //           items,
                //       //           style: GoogleFonts.poppins(
                //       //             fontSize: 14,
                //       //             fontWeight: FontWeight.w400,
                //       //             color: Colors.white,
                //       //           ),
                //       //         ),
                //       //       ),
                //       //     );
                //       //   }).toList(),
                //       //   onChanged: (String? newValue) {
                //       //     setState(() {
                //       //       dropdownvalue2 = newValue!;
                //       //     });
                //       //   },
                //       //   isExpanded: true,
                //       // ),
                //     ),
                //   ],
                // ),
                SizedBox(


                  child: TextFormField(
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showCurrencyPickerDialog,
                        icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                      ),
                      labelText: 'Country',
                      labelStyle: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight
                              .w500,
                          fontSize: 14
                      ),

                      hintText:
                      'Country',
                      hintStyle:  GoogleFonts.montserrat(

                        color: Colors.white,
                        fontWeight: FontWeight
                            .w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.only(top: 50,left: 20),
                      filled: true,
                      fillColor:primarycolor1,

                    ),
                    readOnly: true,
                    controller: countryController,
                  ),
                ),
                SizedBox(
                  height: width * 0.025,
                ),
                SizedBox(
                  height: width * 0.15,
                  child: TextFormField(
                    // autovalidateMode: AutovalidateMode.always,
                      controller: jobController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Job number ',
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter your Job number...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: primarycolor1,
                        contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                      ),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                SizedBox(
                  height: width * 0.025,
                ),
//job

                // SizedBox(
                //   height: width * 0.15,
                //
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       labelText: 'Currency',
                //       labelStyle: GoogleFonts.montserrat(
                //           color: Colors.white,
                //           fontWeight: FontWeight
                //               .w500,
                //           fontSize: 14
                //       ),
                //
                //       hintText:
                //       'Currency',
                //       hintStyle: GoogleFonts.montserrat(
                //
                //         color: Colors.white,
                //         fontWeight: FontWeight
                //             .w500,
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //           width: 1,
                //         ),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //           width: 1,
                //         ),
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       filled: true,
                //       fillColor: primarycolor1,
                //       contentPadding: EdgeInsets.only(top: 50,left: 20),
                //
                //     ),
                //
                //     readOnly: true,
                //     controller: currencyController,
                //   ),
                // ),
                // SizedBox(
                //   height: width * 0.05,
                // ),
                SizedBox(
                  height: width * 0.15,
                  child: TextFormField(
                    // autovalidateMode: AutovalidateMode.always,
                      controller: _cabnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Cab name ',
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter your cab name...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: primarycolor1,
                        contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                      ),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                // SizedBox(
                //   height: width * 0.05,
                // ),
                SizedBox(
                  height: width * 0.025,
                ),
                SizedBox(
                  height: width * 0.15,
                  child: TextFormField(
                      controller: _doornumberController,
                      decoration: InputDecoration(
                        labelText: 'Door number',
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter your door number...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: primarycolor1,
                        contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                      ),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                SizedBox(
                  height: width * 0.04,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         _imgurl.length > 1 ? showUploadMessage(
                //             context, "can't upload", style: GoogleFonts
                //             .poppins()) : _pickImage();
                //       },
                //       child: Container(
                //         height: 30,
                //         width: 50,
                //         color: Colors.white,
                //         child: Icon(Icons.camera_alt, color: Colors.black,),
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () {
                //         _imgurl.length > 1 ? showUploadMessage(
                //             context, "can't upload", style: GoogleFonts
                //             .poppins()) : _pickImages();
                //       },
                //       child: Container(
                //         height: 30,
                //         width: 50,
                //         color: Colors.white,
                //         child: Icon(
                //           Icons.browse_gallery_outlined, color: Colors.black,),
                //       ),
                //     ),
                //
                //   ],
                // ),
                SizedBox(
                  height: width * 0.04,
                ),
                // Container(
                //   height: 100,
                //   child: ListView(
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       _imgurl.isEmpty ? Container() : Padding(
                //         padding: EdgeInsets.only(left: 10),
                //         child: InkWell(
                //           onLongPress: () {
                //             _imgurl.removeAt(0);
                //             setState(() {
                //
                //             });
                //           },
                //           child: Container(
                //             height: height * 0.11,
                //             width: width * 0.28,
                //             decoration: BoxDecoration(
                //               image: DecorationImage(
                //                   image: NetworkImage(_imgurl[0]),
                //                   // FileImage(imgFile!) as ImageProvider,
                //                   fit: BoxFit.fill),
                //               borderRadius: BorderRadius.circular(8),
                //               border: Border.all(
                //                 color: Color(0xffDADADA),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //       _imgurl.length == 2 ? Padding(
                //         padding: EdgeInsets.only(left: 10),
                //         child: InkWell(
                //           onLongPress: () {
                //             _imgurl.removeAt(1);
                //             setState(() {
                //
                //             });
                //           },
                //           child: Container(
                //             height: height * 0.11,
                //             width: width * 0.28,
                //             decoration: BoxDecoration(
                //               image: DecorationImage(
                //                   image: NetworkImage(_imgurl[1].toString()),
                //                   // FileImage(imgFile!) as ImageProvider,
                //                   fit: BoxFit.fill),
                //               borderRadius: BorderRadius.circular(8),
                //               border: Border.all(
                //                 color: Color(0xffDADADA),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ) : Container(),
                //     ],
                //   ),
                //
                // ),
                SizedBox(
                  height: width * 0.04,
                ),




                    InkWell(
                  onTap: () async {
                    if (_namecontroller.text.isEmpty) {
                      refreshPage();
                      return showUploadMessage1(context, "Must Provide Name",
                          style: GoogleFonts.poppins());
                    }
                    if (countryController.text.isEmpty) {
                      refreshPage();
                        return showUploadMessage1(context, "Please select Country",
                          style: GoogleFonts.poppins());
                    }
                    else if (_emailcontroller.text.isEmpty) {
                      refreshPage();
                      return showUploadMessage1(
                          context, "Please Enter Email Address",
                          style: GoogleFonts.poppins());
                    } else if (_phoneController.text.isEmpty) {
                      refreshPage();
                      return showUploadMessage1(
                          context, "Please Enter PhoneNumber",
                          style: GoogleFonts.poppins());
                    }
                    // if (_icamaController.text.isEmpty) {
                    //   refreshPage();
                    //   return showUploadMessage(
                    //       context, "Must Provide Icama Number",
                    //       style: GoogleFonts.poppins());
                    // }
                    else if (_companynameController.text.isEmpty) {
                      refreshPage();
                      return showUploadMessage1(
                          context, "Please Enter company Name",
                          style: GoogleFonts.poppins());
                    }

                    else if (_cabnameController.text.isEmpty) {
                      refreshPage();
                      return showUploadMessage1(
                          context, "Please Enter cabname", style: GoogleFonts
                          .poppins());
                    }
                    else if (_doornumberController.text.isEmpty) {
                      refreshPage();
                      return showUploadMessage1(
                          context, "Please enter door number",
                          style: GoogleFonts.poppins());
                    }
                    else if (jobController.text.isEmpty) {
                      refreshPage();
                      return showUploadMessage1(
                          context, "Please enter job number",
                          style: GoogleFonts.poppins());
                    }
                    else if (imgUrl == null) {
                      refreshPage();
                      return showUploadMessage1(context, "Please upload photo",
                          style: GoogleFonts.poppins());
                    }

                    else {

                      showDialog(context: context,
                          builder: (buildcontext) {
                            return AlertDialog(
                              title: Text(
                                'Edit Member', style: GoogleFonts.montserrat(),),
                              content: Text('Do you want to Add?',
                                  style: GoogleFonts.montserrat()),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(buildcontext);
                                },
                                    child: Text(
                                        'Cancel', style: GoogleFonts.montserrat())),
                                TextButton(onPressed: () async {

                                  if(widget.bookMembers.contains(_emailcontroller.text)){
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.userData.userId).update(
                                        {
                                          'userImage':imgUrl??"",
                                          'phone': _phoneController.text ?? '',
                                          'userEmail': _emailcontroller.text ?? '',
                                          'userName': _namecontroller.text ?? '',
                                          // icamaNumber:_icamaController.text ??  "",
                                          // cardImage: _imgurl ?? [],
                                          'doorNumber': _doornumberController.text ?? "",
                                          'cabName': _cabnameController.text ?? "",
                                          'companyName': _companynameController.text ?? '',
                                          'country': countryController.text ?? "",
                                          'countryCode': countryCode?? "",
                                          'currencyShort': currency?? "",
                                          'jobNumber':jobController.text,
                                          'shopId':currentshopId

                                        });
                                  } else {
                                    List prev = widget.bookMembers;

                                    int i=prev.indexWhere((element) => element==widget.userData.userEmail);


                                    if(i != (-1)) {
                                      prev[i]=_emailcontroller.text;
                                    }


                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.userData.userId).update(
                                        {
                                          'userImage':imgUrl??"",
                                          'phone': _phoneController.text ?? '',
                                          'phonePrefix': phonePrefix ?? '',
                                          'whatsappNumber': _whatsappNumberController.text ?? '',
                                          'userEmail': _emailcontroller.text ?? '',
                                          'userName': _namecontroller.text ?? '',
                                          // icamaNumber:_icamaController.text ??  "",
                                          // cardImage: _imgurl ?? [],
                                          'doorNumber': _doornumberController.text ?? "",
                                          'cabName': _cabnameController.text ?? "",
                                          'companyName': _companynameController.text ?? '',
                                          'country': countryController.text ?? "",
                                          'countryCode': countryCode?? "",
                                          'currencyShort': currency?? "",
                                          'jobNumber':jobController.text,
                                          'shopId':currentshopId

                                        }).then((value) {
                                          FirebaseFirestore.instance.collection('shops')
                                              .doc(widget.shopId)
                                              .collection('book')
                                              .doc(widget.bookId)
                                              .update({
                                            'members' : prev ,
                                          });
                                    });

                                  }


                                  Navigator.pop(context);
                                  setState(() {

                                  });

                                  showUploadMessage1(
                                      context, 'member updated successfully',
                                      style: GoogleFonts.montserrat());
                                  Navigator.pop(buildcontext);
                                  Navigator.pop(context);

                                  setState(() {

                                  });


                                  // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => ManagePage(),), (route) => false);
                                },
                                    child: const Text('Yes')),
                              ],
                            );
                          });


                    }
                  },
                  child: Container(
                    height: width * 0.13,
                    width: width * 1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(38),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff323333).withOpacity(0.25),
                              blurRadius: 6,
                              spreadRadius: 0,
                              offset: Offset(4, 3))
                        ]),
                    child: Center(
                      child: Text(
                        "Edit Member",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff6E788E)),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: width * 0.25,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Already have an account?",
                //       style: GoogleFonts.poppins(
                //           fontSize: 13,
                //           fontWeight: FontWeight.w500,
                //           color: Color(0xffFFFFFF).withOpacity(0.70)),
                //     ),
                //     SizedBox(
                //       width: width * 0.015,
                //     ),
                //     Text(
                //       "Log in",
                //       style: GoogleFonts.poppins(
                //           fontSize: 13,
                //           fontWeight: FontWeight.w700,
                //           color: Color(0xffFFFFFF)),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // createUser(UserModel user) async {
  //   FirebaseFirestore.instance
  //       .collection('users').
  //   // doc(user.userId).
  //   add(user.toJson()).then((value) {
  //
  //     value.update({
  //       'userId':value.id
  //
  //     });
  //
  //   }).then((value) {
  //     // FirebaseFirestore.instance
  //     //     .collection('shops')
  //     //     .doc(currentshopId)
  //     //     .collection('book').doc(
  //     //     widget.bookData.bookId)
  //     //     .update({
  //     //   'members': FieldValue.arrayUnion([user.userEmail]),
  //     //
  //     // });
  //   });
  // }
}
