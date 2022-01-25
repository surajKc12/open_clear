import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../constant.dart';

class CloudStorageController {
  static Future<Map<ARGS, String>> uploadPhotoFile({
    required File photo,
    String? filename,
    required String uid,
  }) async {
    filename ??= '${Constant.PHOTO_IMAGES_FOLDER}/$uid/${Uuid().v1()}';
    UploadTask task = FirebaseStorage.instance.ref(filename).putFile(photo);
    task.snapshotEvents.listen((TaskSnapshot event) {
      int progress = (event.bytesTransferred / event.totalBytes * 100).toInt();
      print('----Progress: $progress');
    });
    await task;
    String downloadURL =
    await FirebaseStorage.instance.ref(filename).getDownloadURL();
    return {
      ARGS.DownloadURL: downloadURL,
      ARGS.Filename: filename,
    };
  }


  static Future<Map<ARGS, String>> uploadItemPhoto({
    required File photo,
    String? filename,
    required String uid,
  }) async {
    filename ??= '${Constant.PHOTO_IMAGES_FOLDER}/${Constant.WARDROBE_IMAGES_FOLDER}/$uid/${Uuid().v1()}';
    UploadTask task = FirebaseStorage.instance.ref(filename).putFile(photo);
    task.snapshotEvents.listen((TaskSnapshot event) {
      int progress = (event.bytesTransferred / event.totalBytes * 100).toInt();
      print('----Progress: $progress');
    });
    await task;
    String downloadURL =
    await FirebaseStorage.instance.ref(filename).getDownloadURL();
    return {
      ARGS.DownloadURL: downloadURL,
      ARGS.Filename: filename,
    };
  }


}
