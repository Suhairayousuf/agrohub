// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
// import 'package:printing/printing.dart';
// import '../../../models/RunnerFinanacialPdfModel.dart';

import 'dart:io';

import 'package:agrohub/features/Book/report/pdf/pdf_api.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../Model/bookModel.dart';


var sign;
var format = NumberFormat.simpleCurrency(locale: 'en_in');

class RunnerFinanceApi {
  static Future<File?> generate(String companyName,List<BookModel> books,List users,List phones,List transactions,List purchases,double total) async {

    final pdf = Document();

    pdf.addPage(MultiPage(
      header: (context) =>Center(
        child: Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              Text(
                'COMPANY REPORT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 1.5,
                ),
              ),
              Text(
                'COMPANY NAME :- $companyName',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 1.5,
                ),
              ),
              Text(
                'Date :- ${DateFormat('dd-MMM-yyyy').format(DateTime.now())}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 1.5,
                ),
              )
            ]
        )
      ),
      build: (context) =>[

        // pw.SizedBox(height: 20),
        // Container(
        //   // width: double.infinity,
        //
        //   child: Column(children: [
        //     Row(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Expanded(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   'To,',
        //                   style: pw.TextStyle(
        //                     fontSize: 14,
        //                     fontWeight: pw.FontWeight.bold,
        //                   ),
        //                 ),
        //                 pw.SizedBox(height: 5),
        //                 Text(
        //                   invoice.customerName!,
        //                   style: pw.TextStyle(
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //                 Text(
        //                   invoice.address!,
        //                   style: pw.TextStyle(
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //                 Text(
        //                   invoice.customerPhoneNo!,
        //                   style: pw.TextStyle(
        //                     fontSize: 12,
        //                   ),
        //                 ),
        //                 pw.SizedBox(height: 8),
        //               ],
        //             ),
        //           ),
        //           pw.SizedBox(width: 5),
        //           Expanded(
        //             child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'From,',
        //                     style: pw.TextStyle(
        //                       fontSize: 14,
        //                       fontWeight: pw.FontWeight.bold,
        //                     ),
        //                   ),
        //                   pw.SizedBox(height: 5),
        //                   Text(
        //                     currentbranchName,
        //                     // 'First Logic Meta Lab Pvt. Ltd',
        //                     style: pw.TextStyle(
        //                       fontSize: 12,
        //                     ),
        //                   ),
        //                   Text(
        //                     currentbranchAddress,
        //                     // '',
        //                     style: pw.TextStyle(
        //                       fontSize: 12,
        //                     ),
        //                   ),
        //                   Text(
        //                     currentbranchphoneNumber,
        //                     style: pw.TextStyle(
        //                       fontSize: 12,
        //                     ),
        //                   ),
        //                 ]),
        //           )
        //         ]),
        //     // pw.SizedBox(height: 25),
        //     // pw.Row(children: [
        //     //   pw.Expanded(
        //     //     child: pw.Row(children: [
        //     //       pw.Expanded(
        //     //         child: pw.Container(
        //     //           height: 50,
        //     //           color: PdfColors.grey300,
        //     //           child: pw.Center(
        //     //             child: pw.Column(
        //     //               mainAxisAlignment:
        //     //                   pw.MainAxisAlignment.center,
        //     //               crossAxisAlignment:
        //     //                   pw.CrossAxisAlignment.start,
        //     //               children: [
        //     //                 pw.Text('Date'),
        //     //                 pw.SizedBox(height: 5),
        //     //                 pw.Text(invoice.date,
        //     //                     style: pw.TextStyle(
        //     //                       fontWeight: pw.FontWeight.bold,
        //     //                       fontSize: 13,
        //     //                     )),
        //     //               ],
        //     //             ),
        //     //           ),
        //     //         ),
        //     //       ),
        //     //       pw.SizedBox(width: 3),
        //     //       pw.Expanded(
        //     //         child: pw.Container(
        //     //             height: 50,
        //     //             color: PdfColors.grey300,
        //     //             child: pw.Center(
        //     //               child: pw.Column(
        //     //                 mainAxisAlignment:
        //     //                     pw.MainAxisAlignment.center,
        //     //                 crossAxisAlignment:
        //     //                     pw.CrossAxisAlignment.start,
        //     //                 children: [
        //     //                   pw.Text('Receipt No.'),
        //     //                   pw.SizedBox(height: 5),
        //     //                   pw.Text(invoice.receiptNo,
        //     //                       style: pw.TextStyle(
        //     //                         fontWeight: pw.FontWeight.bold,
        //     //                         fontSize: 13,
        //     //                       )),
        //     //                 ],
        //     //               ),
        //     //             )),
        //     //       )
        //     //     ]),
        //     //   ),
        //     //   pw.SizedBox(width: 5),
        //     //   pw.Expanded(
        //     //     child: pw.Row(
        //     //         mainAxisAlignment: pw.MainAxisAlignment.start,
        //     //         crossAxisAlignment: pw.CrossAxisAlignment.start,
        //     //         children: [
        //     //           pw.Expanded(
        //     //             child: pw.Container(
        //     //               height: 50,
        //     //               color: PdfColors.grey300,
        //     //               child: pw.Center(
        //     //                 child: pw.Column(
        //     //                   mainAxisAlignment:
        //     //                       pw.MainAxisAlignment.center,
        //     //                   crossAxisAlignment:
        //     //                       pw.CrossAxisAlignment.start,
        //     //                   children: [
        //     //                     pw.Text('Mode of Payment'),
        //     //                     pw.SizedBox(height: 5),
        //     //                     pw.Text(invoice.paymentMethod,
        //     //                         style: pw.TextStyle(
        //     //                           fontWeight: pw.FontWeight.bold,
        //     //                           fontSize: 13,
        //     //                         )),
        //     //                   ],
        //     //                 ),
        //     //               ),
        //     //             ),
        //     //           ),
        //     //           pw.SizedBox(width: 3),
        //     //           pw.Expanded(
        //     //             child: pw.Container(
        //     //               height: 50,
        //     //               color: PdfColors.grey300,
        //     //               child: pw.Center(
        //     //                 child: pw.Column(
        //     //                   mainAxisAlignment:
        //     //                       pw.MainAxisAlignment.center,
        //     //                   crossAxisAlignment:
        //     //                       pw.CrossAxisAlignment.start,
        //     //                   children: [
        //     //                     pw.Text('Due Amount.'),
        //     //                     pw.SizedBox(height: 5),
        //     //                     pw.Text(
        //     //                         ' ${invoice.totalDue.toStringAsFixed(2)}',
        //     //                         style: pw.TextStyle(
        //     //                           fontWeight: pw.FontWeight.bold,
        //     //                           fontSize: 13,
        //     //                         )),
        //     //                   ],
        //     //                 ),
        //     //               ),
        //     //             ),
        //     //           )
        //     //         ]),
        //     //   )
        //     // ]),
        //   ]),
        // ),
        pw.SizedBox(height: 25),

        ///

        ///TABLE

        pw.Table.fromTextArray(
          cellAlignment: Alignment.center,
          border: pw.TableBorder(
            left: pw.BorderSide(),
            right: pw.BorderSide(),
            bottom: pw.BorderSide(),
            top: pw.BorderSide(),
            horizontalInside: pw.BorderSide.none,
            verticalInside: pw.BorderSide(),

          ),

          headerDecoration: BoxDecoration(
            border: Border.all(width: 1)
          ),
          context: context,
          headers: [
            'Sl No.',
            'Name',
            'Book Name',
            'Phone',
            'Last Purchase',
            'Last Payment',
            'Balance',
            // 'Balance',
          ],
          data: List.generate(books.length + 2, (index) {
            // final summary = datas[index];



            return index == books.length
                ? [
              '',
              '',
              '',
              '',
              '',
              '',
              ''
              ]
                :index==books.length+1?[
              '',
              'Total',
              '',
              '',
              '',
              '',
              total

            ]
                : [
                  (index+1).toString(),
              users[index]==companyName?'':users[index],
              books[index].bookName,
              phones[index],
            purchases[index]==companyName?'':purchases[index],
              transactions[index]==companyName?'':transactions[index],
              (books[index].credit??0).toStringAsFixed(2),

              // _formatNumber(balance.toString().replaceAll(',', ''))
            ];
          }),
        ),
      ],
    ));

    if(kIsWeb){
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save());
    }
    else{
      return PdfApi.saveDocument(name:'$companyName.pdf', pdf: pdf);


    }
    return null;

  }


}