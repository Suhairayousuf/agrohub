import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff445A89),
        // leading: Icon(Icons.arrow_back),
        title: Text("Purchase",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: h / 20, left: w / 15, right: w / 15),
        child: Column(
          children: [
            Container(
              width: h / 2,
              height: h / 4.8,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff565656)),
                  borderRadius: BorderRadius.circular(7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: h / 40),
                        child: Container(
                          width: w / 4.7,
                          height: h / 7,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff565656)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Image(
                            image: AssetImage('assets/image/addphoto.svg'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: h / 40),
                        child: Container(
                          width: w / 4.7,
                          height: h / 7,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff565656)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Image(
                            image: AssetImage('assets/image/addphoto.svg'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: h / 40,
                        ),
                        child: Container(
                          width: w / 4.7,
                          height: h / 7,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff565656)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Image(
                            image: AssetImage('assets/image/addphoto.svg'),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h / 60,
                  ),
                  Text("*upload minimum 1 or maximum 3 photos",
                      style: TextStyle(
                        fontSize: 6,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: h/30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: w / 2.5,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Invoice No",
                        fillColor: Colors.transparent,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400))),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text('Cash'),
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text('Credit'),
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h/30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: w / 2.4,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Amount",
                        fillColor: Colors.transparent,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400))),
                  ),
                ),
                SizedBox(
                  height: h/30,
                ),
                SizedBox(
                  width: w / 2.4,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "VAT",
                        fillColor: Colors.transparent,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h/30,
            ),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: "Description",
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400))),
            ),
            SizedBox(
              height: h/30,
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: w/3.5,
                height: h/20,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff445A89), // Background color
                  ),
                  child: Text('Enter'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
