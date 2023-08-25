import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:reminder_app/constant/widget/loading.dart';
import 'package:reminder_app/models/user.dart';
import 'package:reminder_app/models/video.dart';
import 'package:reminder_app/view/main_menu/main_menu.dart';

class FirebaseServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference productsRef =
      FirebaseFirestore.instance.collection('videos');
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');

  uploadVideo({required VideoModel data}) async {
    try {
      SmartDialog.showLoading(
        animationBuilder: (controller, child, animationParam) {
          return Loading(
            text: 'Please wait...',
          );
        },
      );
      await productsRef.doc().set(data.toMap()).then((value) {
        Get.offAll(() => const MainMenu());
        SmartDialog.dismiss();
      });
    } catch (e) {
      print(e);
    }
  }

  updateProfile(UserModel userModel) async {
    try {
      SmartDialog.showLoading(
        animationBuilder: (controller, child, animationParam) {
          return Loading(
            text: 'Please wait...',
          );
        },
      );
      await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(userModel.toMap());
      SmartDialog.dismiss();
      Get.offAll(() => const MainMenu());
    } catch (e) {
      print(e);
    }
  }

  Future<void> addCategoryEng({
    required String categoryText,
    required BuildContext context,
  }) async {
    DocumentSnapshot snap = await category.doc('category').get();
    List categories = (snap.data() as dynamic)['category'];
    try {
      if (categories.contains(categoryText)) {
        return;
      } else {
        category.doc('category').update({
          'category': FieldValue.arrayUnion([categoryText])
        });
      }
    } catch (err) {
      err.toString();
    }
  }
}
