
import 'dart:io';

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
class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  late _Controller con;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  File? photo;
  void render(fn) => setState(fn);
  @override
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
        title: const Text('Add Card'),
        actions: [
          IconButton(onPressed: con.addCard, icon: const Icon(Icons.done, color: Colors.blue,size: 35,))
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 30.h,),
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),

                  ),
                  child: photo!=null?Image.file(photo!): const Icon(Icons.upload_file, size: 50,color: Colors.grey,),),

                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.only(top: 10.0.h, left: 20.0.w, right: 20.0.h),
                  child: TextFormField(
                    onSaved: con.saveDescription,
                    validator: Validation.validateDescription,
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
  late _AddCardScreenState state;
  _Controller(this.state);
  String? description;
  MyCard card = MyCard();

  String? saveDescription(String? value) {
    if (value != null) description = value;
    return description;
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

  void addCard() async {
    FormState? currentState = state.formkey.currentState;
    if (currentState == null || !currentState.validate()) return;

    currentState.save();
    if (state.photo == null) {
      MyDialog.showSnackBar(
        context: state.context,
        message: 'Photo not Selected',
      );
      return;
    }


    MyDialog.circularProgressStart(state.context);
    try {
      Map photoInfo = await CloudStorageController.uploadPhotoFile(
          photo: state.photo!,
          uid: FirebaseAuth.instance.currentUser!.uid);
      card.cardOwnerId= FirebaseAuth.instance.currentUser!.uid;
      card.cardDescription=description!;
      card.email=FirebaseAuth.instance.currentUser!.email!;
      card.photoURL=photoInfo[ARGS.DownloadURL];
      card.photoFilename=photoInfo[ARGS.Filename];
      card.timestamp = DateTime.now();
      card.docId=await FirestoreConroller.addCard(card: card);
      MyDialog.circularProgressStop(state.context);
      Navigator.pop(state.context);
      MyDialog.showSnackBar(
          context: state.context,
          message: 'Card Added Successfully');

    } catch (e) {
      MyDialog.circularProgressStop(state.context);
      if (Constant.DEV) print('---Add card error: $e');
      MyDialog.showSnackBar(
        context: state.context,
        message: 'Cannot add card: $e',
      );
    }
  }

}