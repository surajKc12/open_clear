import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_clear/model/card.dart';
import 'package:open_clear/service/cloudStorage_service.dart';
import 'package:open_clear/service/firestore_service.dart';
import 'package:open_clear/widgets/my_dialog.dart';

import '../constant.dart';
import '../validator.dart';
class EditScreen extends StatefulWidget {
  final MyCard card;
  const EditScreen({Key? key, required this.card}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late _Controller con;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  File? photo;
  void render(fn) => setState(fn);
  void initState() {
    // TODO: implement initState
    con = _Controller(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black,
        title: const Text('Edit Card'),
        actions: [
          TextButton(onPressed: con.update, child: const Text("Update"))
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.h,),
                 Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),

                  ),
                   child: photo!=null?Image.file(photo!)
                       :
                   CachedNetworkImage(
                       imageUrl: widget.card.photoURL,
                     placeholder: (context, url) => CircularProgressIndicator(),
                   )
                 ),

                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.only(top: 10.0.h, left: 20.0.w, right: 20.0.w),
                  child: TextFormField(
                    controller: TextEditingController(text: widget.card.cardDescription),
                    onSaved: con.saveDescription,
                    validator: Validation.validateName,
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                SizedBox(height: 20.h,),
                ElevatedButton(onPressed: con.getPhoto, child: const Text("Choose Image"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  late _EditScreenState state;
  late MyCard card;
  File? photo;

  _Controller(this.state) {
    card = MyCard.clone(state.widget.card);
  }
  void getPhoto() async {
    try {
      showDialog(
        context: state.context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      Navigator.pop(state.context);
                      photo=File(image.path);
                      state.render(() {
                        state.photo = File(image.path);
                      });
                    },
                    child: const Text("From Gallery")),
                ElevatedButton(
                    onPressed: () async {
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      Navigator.pop(state.context);
                      photo=File(image.path);
                      state.render(() {
                        state.photo = File(image.path);
                      });
                    },
                    child: const Text("From Camera")),


              ],
            ),
          );
        },
      );
    } catch (e) {
      if (Constant.DEV) print('----Failed to get a pic: $e');
      MyDialog.showSnackBar(
        context: state.context,
        message: 'Failed to get a picture: $e',
      );
    }
  }

  void update() async {
    FormState? currentState = state.formkey.currentState;
    if (currentState == null || !currentState.validate()) return;
    currentState.save();
    MyDialog.circularProgressStart(state.context);
    try {
      Map<String, dynamic> updateInfo = {};
      if (photo != null) {
        Map photoInfo = await CloudStorageController.uploadPhotoFile(
          photo: photo!,
          uid: FirebaseAuth.instance.currentUser!.uid,
          filename: card.photoFilename,
        );

        // generate image labels by ML


        card.photoURL = photoInfo[ARGS.DownloadURL];
        updateInfo[MyCard.PHOTO_URL] = card.photoURL;
      }


      if (card.cardDescription != state.widget.card.cardDescription)
        updateInfo[MyCard.CARD_DESCRIPTION] = card.cardDescription;

      if (updateInfo.isNotEmpty) {
        card.timestamp = DateTime.now();
        updateInfo[MyCard.TIMESTAMP] = card.timestamp;
        await FirestoreConroller.updatePhotoMemo(
            docId: card.docId!, updateInfo: updateInfo);
        state.widget.card.assign(card);
      }

      MyDialog.circularProgressStop(state.context);
    } catch (e) {
      MyDialog.circularProgressStop(state.context);
      if (Constant.DEV) print('----update photomemo error: $e');
      MyDialog.showSnackBar(
        context: state.context,
        message: 'Update PhotoMemo error: $e',
      );
    }
  }


  void saveDescription(String? value) {
    if (value != null) card.cardDescription = value;
  }

}
