import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../auth/screen/splash.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  TextEditingController mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
      ),
      body: Column(
        children: [
          SizedBox(
            height: width * 0.15,
          ),
          Container(
            width: width * 0.6,
            height: width * 0.6,
            decoration: BoxDecoration(
              // border: Border.all(color: primarycolor1),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: SizedBox(child: Lottie.asset('assets/68692-qr-code-scanner.json'),width: width*0.5,),
          ),
          SizedBox(
            height: width * 0.1,
          ),
          InkWell(
            child: Center(
              child: Container(
                height: width * 0.15,
                width: width * 0.4,
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [primarycolor1, primarycolor2]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Scanner',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: width * 0.1,
          ),
          Container(
            height: width * 0.17,
            width: width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(color: primarycolor1),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextFormField(
                controller: mobileNumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'PhoneNumber',
                  labelStyle: GoogleFonts.montserrat(color: primarycolor2, fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: width * 0.1,
          ),
          InkWell(
            child: Center(
              child: Container(
                height: width * 0.15,
                width: width * 0.4,
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [primarycolor1, primarycolor2]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
