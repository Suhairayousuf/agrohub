import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../../Model/purchase/purchaseModel.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/color.dart';
import '../../../Home/screen/homePage.dart';
import '../../../Home/screen/selectShop.dart';
import '../../../auth/screen/splash.dart';


class SendBill extends StatefulWidget {
  final String phone;
  final String name;
  final String id;
  final String bookId;
  final String bookName;
  final double creditLimit;
  final double bookCredit;
  const SendBill({Key? key, required this.phone, required this.name, required this.id, required this.bookId, required this.bookName, required this.creditLimit, required this.bookCredit}) : super(key: key);

  @override
  State<SendBill> createState() => _SendBillState();
}

class _SendBillState extends State<SendBill> {

  late TextEditingController phone;
  late TextEditingController item;
  late TextEditingController amount;
  late TextEditingController total;
  int itemCount=1;
  final RoundedLoadingButtonController _btnController1 =
  RoundedLoadingButtonController();

  @override
  void initState() {
    phone=TextEditingController(text: widget.phone);
    item=TextEditingController();
    amount=TextEditingController();
    total=TextEditingController();
    super.initState();
  }
  createPurchase(PurchaseModel purchaseData,)  {
    bool error = false;
    try{
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference a=FirebaseFirestore.instance
            .collection('users')
            .doc(purchaseData.customerId)
            .collection('purchase').doc();
        purchaseData.purchaseId=a.id;
        transaction.set (a, purchaseData.toJson());
        transaction.update(FirebaseFirestore.instance
            .collection('shops')
            .doc(currentshopId)
            .collection('book')
            .doc(widget.bookId), {
          'credit': FieldValue.increment(purchaseData.amount ?? 0.00),
          'update': DateTime.now(),
        });
        transaction.update(FirebaseFirestore.instance.collection('shops').doc(currentshopId), {
          'totalCredit': FieldValue.increment(purchaseData.amount ?? 0.00),
        });

      })
          .catchError((err){
        error=true;
        showErrorMessage(context, err.toString(), style:  GoogleFonts.montserrat());
      });
      if(mounted && !error){
        showUploadMessage1(context,
            'amount added successfully',
            style: GoogleFonts
                .montserrat());
      }
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(purchaseData.customerId)
      //     .collection('purchase')
      //     .add(purchaseData.toJson())
      //     .then((value) {
      //   value.update({'purchaseId': value.id});
      // });
      // FirebaseFirestore.instance
      //     .collection('shops')
      //     .doc(currentshopId)
      //     .collection('book')
      //     .doc(widget.bookId)
      //     .update({
      //   'credit': FieldValue.increment(purchaseData.amount ?? 0.00),
      //   'update': DateTime.now(),
      // });
      //
      // FirebaseFirestore.instance.collection('shops').doc(currentshopId).update({
      //   'totalCredit': FieldValue.increment(purchaseData.amount ?? 0.00),
      // });
    }catch(e){
      showErrorMessage(context, e.toString(), style:  GoogleFonts.montserrat());
    }
  }
  List items=[];
  bool _value=false;
  bool isChecked = true;
  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid,  result);
    //Add invoice footer
    drawFooter(page, pageSize);
    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    final directory = await getApplicationSupportDirectory();

//Get directory path
    final path = directory.path;
    String output=Timestamp.now().nanoseconds.toString();
    print('dfghj'+ output);

//Create an empty file to write PDF data
    File file = File('$path/${output}.pdf');

//Write PDF data
    await file.writeAsBytes(bytes, flush: true);

//Open the PDF document in mobile
    if(isChecked){
      final purchaseData = PurchaseModel(
          amount: double.tryParse(grandTotal.toString()) ?? 0,
          customerId: widget.id,
          customerName: widget.name,
          customerPhone: widget.phone,
          shopId: currentshopId,
          shopName: currentshopName,
          image: currentShopImage,
          status: 0,
          verification: false,
          date: DateTime.now(),
          bookId: widget.bookId,
          bookName: widget.bookName,
          noBook: _value,
          currencyShort: currencyCode,
          type: 0,
          delete: false);
      await createPurchase(purchaseData);
      showUploadMessage1(context, 'Transaction added to the book', style: TextStyle());
    }else{
      print('object');
    }
    await Share.shareFiles(['$path/${output}.pdf'],text:'text');
    items=[];
    calculate();
    setState(() {

    });
    // OpenFilex.open('$path/Output.pdf');
    document.dispose();



    _btnController1.reset();
    showUploadMessage1(context, 'Pdf created', style: TextStyle());
    //Save and launch the file.
    // await saveAndLaunchFile(bytes, 'Invoice.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        currentshopName.toString(), PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString(currencyCode=='INR'?'₹':currencyCode.toString()+ " "+getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Bill invoice\r\n\r\nDate: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    String address = '''Bill To: \r\n\r\n${widget.name.toString()}, 
        \r\n\r\nPhone : ${widget.phone}, 
        \r\n\r\nID : ${widget.id} ''';
    //
    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;

    //Draw grand total.
    page.graphics.drawString('Grand Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString(getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    String footerContent =
    // ignore: leading_newlines_in_multiline_strings
    '''${currentshopName}.\r\n\r\n${currentshopPhone},
         ''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Sr.No';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Product Name';
    headerRow.cells[2].value = 'Price';
    headerRow.cells[3].value = 'Quantity';
    headerRow.cells[4].value = 'Total';
    //Add rows
    for(int i=0;i<items.length;i++) {
      addProducts((i + 1).toString(), items[i]['name'], items[i]['amount'],
          items[i]['qty'], (items[i]['amount'] * items[i]['qty']), grid);
    }
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    // addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    // addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    // addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(String productId, String productName, double price,
      int quantity, double total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = productId;
    row.cells[1].value = productName;
    row.cells[2].value = price.toString();
    row.cells[3].value = quantity.toString();
    row.cells[4].value = total.toString();
  }

  //Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
      grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }


  Future<void> _createPDF() async {
    //Create a new PDF document
    PdfDocument document = PdfDocument();

    //Add a new page and draw text
    document.pages.add().graphics.drawString('test', PdfStandardFont(PdfFontFamily.helvetica, 20));
    document.pages.add().graphics.drawString(
        'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(0, 0, 500, 50));

    //Save the document
    List<int> bytes = await document.save();
//Get external storage directory
    final directory = await getApplicationSupportDirectory();

//Get directory path
    final path = directory.path;

//Create an empty file to write PDF data
    File file = File('$path/Output.pdf');

//Write PDF data
    await file.writeAsBytes(bytes, flush: true);

//Open the PDF document in mobile
    OpenFilex.open('$path/Output.pdf');
    //Dispose the document

    document.dispose();
  }
  double grandTotal=0;
  calculate(){
    grandTotal=0;
    for(var data in items){
      grandTotal+=(data['qty']*data['amount']);
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        backgroundColor: primarycolor1,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Customer phone :-',style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 16
              ),),
              SizedBox(height:MediaQuery.of(context).size.width*0.05 ,),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    labelText: "Mobile number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)
                    ),
                    prefixIcon: Icon(Icons.mobile_screen_share_outlined)
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.width*0.1 ,),
              Row(
                children: [
                  Text('Add items :-',style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 16
                  ),),
                  SizedBox(width:MediaQuery.of(context).size.width*0.05 ,),
                  // Expanded(
                  //   child: TextFormField(
                  //     controller: total,
                  //     keyboardType: TextInputType.number,
                  //     onChanged: (value){
                  //       setState(() {
                  //
                  //       });
                  //     },
                  //     decoration: InputDecoration(
                  //         labelText: "Item total amount",
                  //         border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //             borderSide: BorderSide(color: Colors.black)
                  //         ),
                  //         prefixIcon: Icon(Icons.currency_exchange)
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height:MediaQuery.of(context).size.width*0.05 ,),
              TextFormField(
                controller: item,
                keyboardType: TextInputType.name,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    labelText: "Item name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)
                    ),
                    prefixIcon: Icon(Icons.drive_file_rename_outline)
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.width*0.05 ,),
              Row(


                children: [
                  Expanded(
                    child: TextFormField(
                      controller: amount,
                      keyboardType: TextInputType.number,
                      onChanged: (value){
                        setState(() {

                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Item amount",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)
                          ),
                          prefixIcon: Icon(Icons.attach_money_outlined)
                      ),
                    ),
                  ),
                  SizedBox(width:MediaQuery.of(context).size.width*0.05 ,),
                  Expanded(
                    child: Row(

                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              if(itemCount>1){
                                setState(() {
                                  itemCount--;
                                });
                              }
                            },
                            onLongPress: (){

                              if(itemCount>5){
                                print('12567890');
                                setState(() {
                                  itemCount=itemCount-5;
                                });
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width*0.125,
                              decoration: BoxDecoration(
                                  color: primarycolor1
                              ),
                              child: Center(
                                child: Text("-",style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width*0.0625,fontWeight: FontWeight.bold,color: Colors.white
                                ),),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.width*0.125,
                            decoration: BoxDecoration(
                                color: Colors.white
                            ),
                            child: Center(
                              child: Text(itemCount.toString(),style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width*0.0625,fontWeight: FontWeight.bold,color: primarycolor1
                              ),),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){

                              setState(() {
                                itemCount++;
                              });

                            },
                            onLongPress: (){


                              setState(() {
                                itemCount=itemCount+5;
                              });

                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width*0.125,
                              decoration: BoxDecoration(
                                  color: primarycolor1
                              ),
                              child: Center(
                                child: Text("+",style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width*0.0625,fontWeight: FontWeight.bold,color: Colors.white
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height:MediaQuery.of(context).size.width*0.05 ,),
              Center(
                child: InkWell(
                  onTap: (){
                    if(item.text==""){
                      _btnController1.reset();
                      showUploadMessage1(context, 'Please enter item name', style: TextStyle());
                      return;
                    }
                    if(amount.text==""){
                      _btnController1.reset();
                      showUploadMessage1(context, 'Please enter item amount', style: TextStyle());
                      return;
                    }
                    items.add({
                      "name":item.text,
                      "qty":itemCount,
                      "amount":double.tryParse(amount.text.toString()),
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                    item.text="";
                    amount.text="";
                    itemCount=1;
                    setState(() {

                    });
                    calculate();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.width*0.025, MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.width*0.025),
                      child: Text('ADD ITEM',style: TextStyle(
                          fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18
                      ),),
                    ),
                  ),
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.width*0.05 ,),
              Container(
                height:MediaQuery.of(context).size.width*0.075,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(color: Colors.black)
                            )
                        ),
                        child: Center(
                          child: Text("No",style: TextStyle(
                              fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(color: Colors.black)
                            )
                        ),
                        child: Center(
                          child: Text("Item",style: TextStyle(
                              fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(color: Colors.black)
                            )
                        ),
                        child: Center(
                          child: Text("Qty",style: TextStyle(
                              fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(color: Colors.transparent)
                            )
                        ),
                        child: Center(
                          child: Text("Amount",style: TextStyle(
                              fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
                    )
                ),
                child: ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Container(

                      decoration: BoxDecoration(
                          color: index.isEven?primarycolor1.withOpacity(0.2):Colors.white
                        // border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                // decoration: BoxDecoration(
                                //     border: Border(
                                //         right: BorderSide(color: Colors.black)
                                //     )
                                // ),
                                child: Center(
                                  child: Text((index+1).toString(),style: TextStyle(
                                      fontSize: 14,fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                // decoration: BoxDecoration(
                                //     border: Border(
                                //         right: BorderSide(color: Colors.black)
                                //     )
                                // ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                  child: Text(items[index]['name'],style: TextStyle(
                                      fontSize: 14,fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                // decoration: BoxDecoration(
                                //     border: Border(
                                //         right: BorderSide(color: Colors.black)
                                //     )
                                // ),
                                child: Center(
                                  child: Text(items[index]['qty'].toString(),style: TextStyle(
                                      fontSize: 14,fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                // decoration: BoxDecoration(
                                //     border: Border(
                                //         right: BorderSide(color: Colors.transparent)
                                //     )
                                // ),
                                child: Center(
                                  child: Text(items[index]['amount'].toStringAsFixed(2),style: TextStyle(
                                      fontSize: 14,fontWeight: FontWeight.w400
                                  ),),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.width*0.05 ,),
              Text('Grand total : ${grandTotal.toStringAsFixed(2)}',style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 16
              ),),
              SizedBox(height:MediaQuery.of(context).size.width*0.05 ,),
              // Center(
              //   child: InkWell(
              //     onTap: () async {
              //
              //
              //     },
              //     child: Container(
              //       decoration: BoxDecoration(
              //           color: Colors.blue,
              //           borderRadius: BorderRadius.circular(10)
              //       ),
              //       child: Padding(
              //         padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.width*0.025, MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.width*0.025),
              //         child: Text('SEND PDF',style: TextStyle(
              //             fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18
              //         ),),
              //       ),
              //     ),
              //   ),
              // ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text('No book : '),
                        Switch(
                          value: _value,
                          onChanged: (bool newValue) {
                            setState(() {
                              _value = newValue;
                            });
                            print(_value);
                            print(_value);
                          },
                        ),
                        // _value==true?Text('No Book',style: GoogleFonts.montserrat(
                        //     color: Colors.red
                        // ),):SizedBox()
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text('Add to book')
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width*0.05,),
              RoundedLoadingButton(
                successIcon: Icons.cloud,
                failedIcon: Icons.cottage,
                child: Text('ADD & SEND PDF', style: TextStyle(color: Colors.white)),
                controller: _btnController1,
                onPressed: () async {
                  if((widget.bookCredit+(double.tryParse(grandTotal.toString())??0.00))>widget.creditLimit){
                    _btnController1.reset();
                    showUploadMessage1(context, 'Amount greater than credit limit', style: TextStyle());
                    return;
                  }
                  if(items.length==0){
                    _btnController1.reset();
                    showUploadMessage1(context, 'Please enter item name', style: TextStyle());
                    return;
                  }

                  final pdfFile = await generateInvoice();

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
