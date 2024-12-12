import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  String uploadedFileUrl1 = '' ;
  String invoiceNo = '' ;
  String supplier = '' ;
  String amount = '' ;
  String gst = '' ;
  String description = '' ;

  String imgUrl = '';
  bool loading = false;
  late File imgFile;

  bool cashPayment=false;
  bool bankPayment=false;
  late TextEditingController invoiceNoController;
  late TextEditingController supplierController;
  late TextEditingController amountController;
  late TextEditingController gstController;
  late TextEditingController descriptionController;
  @override
  void initState() {
    invoiceNoController=TextEditingController();
    supplierController=TextEditingController();
    amountController=TextEditingController();
    gstController=TextEditingController();
    descriptionController=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primarycolor1,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: const Text("Expense",style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.15,MediaQuery.of(context).size.height*0.05,MediaQuery.of(context).size.width*0.15,MediaQuery.of(context).size.width*0.05),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: ListView(
              children: [
                if (uploadedFileUrl1==null||uploadedFileUrl1=='')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          onPressed: () async {

                            _pickImage();

                            // final selectedMedia = await selectMedia(
                            //   maxWidth: 1080.00,
                            //   maxHeight: 1320.00,
                            // );
                            // if (selectedMedia != null &&
                            //     validateFileFormat(
                            //         selectedMedia.storagePath,
                            //         context)) {
                            //   showUploadMessage(
                            //       context, 'Uploading file...',,style: GoogleFonts.montserrat(),
                            //       showLoading: true);
                            //   final downloadUrl = await uploadData(
                            //       selectedMedia.storagePath,
                            //       selectedMedia.bytes);
                            //   ScaffoldMessenger.of(context)
                            //       .hideCurrentSnackBar();
                            //   if (downloadUrl != null) {
                            //     setState(() =>
                            //     uploadedFileUrl1 = downloadUrl);
                            //     showUploadMessage(context,
                            //         'Media upload Success!',style: GoogleFonts.montserrat());
                            //   } else {
                            //     showUploadMessage(context,
                            //         'Failed to upload media',style: GoogleFonts.montserrat());
                            //   }
                            // }
                          },
                          icon: const Icon(
                            Icons.image_rounded,
                            color: Colors.black,
                            size: 50,
                          ),
                          iconSize: 50,
                        ),
                      ),
                    ],
                  )
                else Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.grey.shade300,
                        child: Image.network(uploadedFileUrl1,fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: () async {

                          _pickImage();

                          // final selectedMedia = await selectMedia(
                          //   maxWidth: 1080.00,
                          //   maxHeight: 1320.00,
                          // );
                          // if (selectedMedia != null &&
                          //     validateFileFormat(
                          //         selectedMedia.storagePath,
                          //         context)) {
                          //
                          //   showUploadMessage(
                          //       context, 'Uploading file...',
                          //       showLoading: true,
                          //       style: GoogleFonts.montserrat(),);
                          //   final downloadUrl = await uploadData(
                          //       selectedMedia.storagePath,
                          //       selectedMedia.bytes);
                          //   ScaffoldMessenger.of(context)
                          //       .hideCurrentSnackBar();
                          //   if (downloadUrl != null) {
                          //     setState(() =>
                          //     uploadedFileUrl1 = downloadUrl);
                          //     showUploadMessage(context,
                          //         'Media upload Success!',style: GoogleFonts.montserrat());
                          //   } else {
                          //     showUploadMessage(context,
                          //         'Failed to upload media',style: GoogleFonts.montserrat());
                          //   }
                          // }
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(0xFF2b0e10),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text('Change Image'
                              ,style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value){
                          setState(() {
                            invoiceNo=value;
                          });
                        },
                        controller: invoiceNoController,
                        decoration: InputDecoration(

                          labelText: 'INVOICE NO',
                          hoverColor: Color(0xFF2b0e10),
                          hintText: 'Enter Invoice Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      // width: MediaQuery.of(context).size.width*0.11,
                      height: 50,
                      child: Row(
                        children: [
                          Text('Cash',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17
                          ),
                          ),
                          Checkbox(
                            value: cashPayment,
                            onChanged: (value) {
                              setState(() {
                                cashPayment = !cashPayment;
                                if(cashPayment==true){
                                  bankPayment=false;
                                }
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width*0.11,

                      height: 50,
                      child: Row(
                        children: [
                          Text('Credit',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17
                          ),
                          ),
                          Checkbox(
                            value: bankPayment,
                            onChanged: (value) {
                              setState(() {
                                bankPayment = !bankPayment;
                                if(bankPayment==true){
                                  cashPayment=false;
                                }

                              });
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            amount=value;
                          });
                        },
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'AMOUNT',
                          hoverColor: Color(0xFF2b0e10),
                          hintText: 'Enter Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: TextField(
                    //     keyboardType: TextInputType.number,
                    //     onChanged: (value){
                    //       setState(() {
                    //         gst=value;
                    //       });
                    //     },
                    //     controller: gstController,
                    //     decoration: InputDecoration(
                    //       labelText: 'Vat',
                    //       hoverColor: Color(0xFF2b0e10),
                    //       hintText: 'Enter Vat',
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5.0),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 20,),
                // TextFormField(
                //   onChanged: (value){
                //     setState(() {
                //       supplier=value;
                //     });
                //   },
                //   controller: supplierController,
                //   decoration: InputDecoration(
                //     labelText: 'SUPPLIER NAME',
                //     hoverColor: Color(0xFF2b0e10),
                //     hintText: 'Enter Supplier Name',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(5.0),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20,),
                TextField(
                  keyboardType: TextInputType.multiline,
                  onChanged: (value){
                    setState(() {
                      description=value;
                    });
                  },
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'DESCRIPTION',
                    hoverColor: Color(0xFF2b0e10),
                    hintText: 'Enter Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {

                        if(invoiceNo.isNotEmpty&&description!=''
                            &&amount!=''&&(cashPayment==true||bankPayment==true)){

                          DocumentSnapshot doc = await FirebaseFirestore.instance
                              .collection('invoiceNo').doc(currentshopId).get();
                          int voucherNo = 1;
                          if(doc.exists){
                             voucherNo = doc.get('expense') + 1;
                          }


                          await FirebaseFirestore.instance.collection('expenses')
                              .doc(currentshopId)
                              .collection('expenses')
                              .add(
                              {
                                'voucherNo': voucherNo,
                                'invoiceNo': invoiceNo,
                                'supplier': supplier,
                                'amount': double.tryParse(amount),
                                'delete':false,
                                // 'gst': double.tryParse(gst),
                                'cash':cashPayment==true?true:false,
                                'image': uploadedFileUrl1,
                                'description': description,
                                'salesDate' :DateTime.now(),
                                'shopId':currentshopId,
                              }).then((value) {
                            FirebaseFirestore.instance.collection('shops')
                                .doc(currentshopId)
                                .update({
                              'totalExpense':FieldValue.increment(num.tryParse(amount)??0),
                            });
                          });
                          if(doc.exists) {
                            FirebaseFirestore.instance.collection('invoiceNo').doc(
                              currentshopId).update(
                              {
                                'expense': FieldValue.increment(1)
                              });
                          }else {
                            FirebaseFirestore.instance
                                .collection('invoiceNo').doc(currentshopId).set({
                              'expense':1,
                              'purchase': 0,
                            });
                          }
                          showUploadMessage1(
                            context, 'Expense Added Succesfully',style: GoogleFonts.montserrat());
                          setState(() {
                            invoiceNoController.text = '';
                            supplierController.text = '';
                            amountController.text = '';
                            gstController.text = '';
                            uploadedFileUrl1 = '';
                            descriptionController.text = '';
                            description = '';
                            invoiceNo = '';
                            supplier = '';
                            amount = '';
                            // gst = '';
                            cashPayment=false;
                            bankPayment=false;
                          });

                        }else{
                          invoiceNo==null?showUploadMessage1(context, 'Please Enter Invoice Number',style: GoogleFonts.montserrat())
                              :(cashPayment==false&&bankPayment==false)?showUploadMessage1(context, 'Please Select Payment Method',style: GoogleFonts.montserrat())
                              :amount==null?showUploadMessage1(context, 'Please Enter Amount',style: GoogleFonts.montserrat())
                          // :gst==null?showUploadMessage(context, 'Please Enter vat Amount')
                              :showUploadMessage1(context, 'Please Enter description',style: GoogleFonts.montserrat());
                        }


                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF2b0e10)
                        ),
                        child: const Center(
                          child: Text("ENTER",style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future uploadImageToFirebase(BuildContext context,) async {
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('deposits/${imgFile.path}');
    UploadTask uploadTask = firebaseStorageRef.putFile(imgFile);
    TaskSnapshot taskSnapshot = (await uploadTask);
    String value = await taskSnapshot.ref.getDownloadURL();

    // if(value!=null){
    //   imageList.add(value);
    // }
    showUploadMessage1(context, 'upload success', showLoading: false, style:GoogleFonts.montserrat());

    setState(() {


      imgUrl = value;


    });
  }

  _pickImage() async {
    loading = true;

    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.camera);
    setState(() {
      imgFile = File(imageFile!.path);

      uploadImageToFirebase(context);
      showUploadMessage1(context, 'Uploading', showLoading: true, style:GoogleFonts.montserrat());
      if(imgFile!=null){
        showUploadMessage1(context, 'upload success', showLoading: false, style:GoogleFonts.montserrat());

      }
    });
  }

}