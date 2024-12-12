import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:pinch_zoom/pinch_zoom.dart';


import '../../../core/utils/utils.dart';
import '../../../themes/color.dart';
import '../../Home/screen/homePage.dart';
import '../../Home/screen/selectShop.dart';
import '../controller/chat_controller.dart';

class ChatPage extends ConsumerStatefulWidget {

  final String userId;
  final String userName;
  const ChatPage({Key? key,  required this.userId, required this.userName}) : super(key: key);

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  FocusNode focusNode = FocusNode();
  bool show = false;
  TextEditingController messageController = TextEditingController();
  File? selectedImage;
  String photourl = '';


  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }
  String? imgUrl='';
  var imgFile;
  var uploadTask;
  var fileUrl;
  var docUrl;
  var uploadTasks;
  bool loading=false;
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
      loading=false;
      // _imgurl.add(value);

      imgUrl = value;

    });
  }
  _pickImage() async {
    loading=true;

    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.camera);
    setState(() {
      imgFile = File(imageFile!.path);
      // _images.add(File(imgFile!.path));

      uploadImageToFirebase(context);

    });
  }
  _pickImages() async {
    loading=true;

    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      // _images.add(File(imgFile!.path));

      uploadImageToFirebase(context);
    });
  }
// set(){
//     setState(() {
//       loading=false;
//     });
// }
//    sendMessage() {
//     if (messageController.text!='' || imgUrl != "") {
//       FirebaseFirestore.instance.collection('users').doc(widget.userId)
//           .collection('chat').add({
//         "message": messageController.text,
//         "image": imgUrl,
//         // "image": selectedImage != null ? selectedImage!.path : null,
//         "receiverId": widget.userId,
//         "senderId": currentshopId,
//         "sendTime": DateTime.now(),
//         "isRead": false,
//       })
//           .then((value) {
//         value.update({'msgId': value.id});
//       });
//
//
//       setState(() {
//
//       });
//     }else{
//       showUploadMessage1(context, 'Enter your mesage', style: GoogleFonts.montserrat());
//     }
//   }
   sendMessage() {
    if (messageController.text!='' || imgUrl != "")
    {
      ref.read(chatControllerProvider.notifier).sendMessage(widget.userId,messageController.text,imgUrl);

    }else{
      showUploadMessage1(context, 'Enter your message', style: GoogleFonts.montserrat());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor1,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 19,
              color: Color(0xffffffff),
            ),
          ),
          title: Text(
            widget.userName ?? "",
            style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
        body: loading?Center(child: CircularProgressIndicator()):StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .collection('chat')
                .snapshots(),
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 19,
                          color: Color(0xffffffff),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName ?? "",
                            style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "online",
                            style: TextStyle(fontSize: 14, color: Color(
                                0xffe3ecf1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userId)
                          .collection('chat')
                          .orderBy('sendTime', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container(
                          color: Colors.white,
                          child: ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var chats = snapshot.data!.docs;
                              Timestamp times =
                              chats[index]['sendTime'];
                              DateTime dates = times.toDate();
                              if ((chats[index]['senderId'] ==
                                  currentshopId || chats[index]['receiverId'] ==
                                  currentshopId) &&
                                  (chats[index]['senderId'] == widget.userId ||
                                      chats[index]['receiverId'] ==
                                          widget.userId)) {

                                if (chats[index]['senderId'] == widget.userId) {
                                  FirebaseFirestore.instance.collection('users').doc(widget.userId)
                                      .collection('chat')
                                      .doc(chats[index]['msgId']??"".toString())
                                      .update({"isRead": true});
                                }
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14, top: 10, bottom: 10),
                                  child: Align(
                                    alignment:chats[index]['senderId'] == widget.userId
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width - 45,
                                        minWidth: 110,
                                      ),
                                      child: Card(
                                        elevation: .7,
                                        shadowColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15),
                                        ),
                                        color: (chats[index]['senderId'] ==currentshopId
                                            ?  primarycolor1
                                            :Colors.grey.withOpacity(0.5)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 30,
                                                top: 5,
                                                bottom: 20,
                                              ),
                                              child: Column(
                                                crossAxisAlignment: chats[index]['senderId'] ==
                                                    widget.userId ? CrossAxisAlignment.start
                                                    : CrossAxisAlignment.end,
                                                children: [
                                                  if (chats[index]['image'] != '')
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.push(context,
                                                            MaterialPageRoute(builder: (context)=>ZoomPage(img: chats[index]['image'].toString(),)));
                                                      },
                                                      child: Container(
                                                        width: 200,
                                                        height: 200,
                                                        child: CachedNetworkImage(imageUrl:chats[index]['image'].toString(),fit: BoxFit.cover,

                                                        ),
                                                      ),
                                                    ),
                                                  if (chats[index]['message']
                                                      .isNotEmpty)
                                                    Text(
                                                      chats[index]["message"],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xffd0dde3)),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 4,
                                              right: 10,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    DateFormat('h:mm a')
                                                        .format(dates)
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff6a777f),

                                                    ),),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    chats[index]['isRead']
                                                        ? Icons
                                                        .done_all
                                                        : Icons.done,
                                                    size: 16,
                                                    color: chats[index]['isRead']
                                                        ? Colors.blue
                                                        : Colors.white,
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      color: Color(0xfff7f7f7),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
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
                            icon: Icon(Icons.attach_file),
                            color: primarycolor1,
                            iconSize: 25,
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: focusNode,
                              controller: messageController,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              decoration: InputDecoration.collapsed(
                                hintText: imgUrl != ''
                                    ? 'Image selected Please send'
                                    : 'Type your message...',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            child: IconButton(
                              icon: Icon(Icons.send),
                              onPressed:() async {
                                await sendMessage();
                                imgUrl='';
                                messageController.clear();
                                messageController.text='';
                                setState(() {

                                });
                              },
                              color: primarycolor1,
                              iconSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

              );
            }),
      ),
    );
  }
}
class ZoomPage extends StatefulWidget {
  final String img;
  const ZoomPage({Key? key, required this.img}) : super(key: key);

  @override
  State<ZoomPage> createState() => _ZoomPageState();
}

class _ZoomPageState extends State<ZoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body:   PinchZoom(
        child: CachedNetworkImage( imageUrl: widget.img,),
        resetDuration: const Duration(minutes: 1),
        maxScale: 2.5,
        onZoomStart: (){print('Start zooming');},
        onZoomEnd: (){print('Stop zooming');},
      ),


    );
  }
}