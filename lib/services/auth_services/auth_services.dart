import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/loading.dart';
import 'package:reminder_app/models/user.dart';
import 'package:reminder_app/view/create_profile/create_profile.dart';
import 'package:reminder_app/view/main_menu/main_menu.dart';

class AuthServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  userRegister({
    email,
    password,
    context,
  }) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'Please wait...',
        );
      },
    );
    try {
      OSDeviceState? status = await OneSignal.shared.getDeviceState();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
        userEmail: email,
        userImage: '',
        userName: '',
        userPhone: '',
        userDescription: '',
        token: status!.userId,
        uid: userCredential.user!.uid,
      );

      if (userCredential.user!.uid.isNotEmpty) {
        users
            .doc(userCredential.user!.uid)
            .set(userModel.toMap())
            .then((value) => {
                  SmartDialog.dismiss(),
                  Get.snackbar('Success !', 'Account Created Successfully',
                      backgroundColor: white),
                  Get.offAll(() => CreateProfile(
                        token: status.userId!,
                        email: email,
                      )),
                });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: '123456');
        if (userCredential.user!.uid.isNotEmpty) {
          Get.snackbar('Login !', 'Successfully Login !',
              backgroundColor: Colors.white54);
          Get.offAll(() => const MainMenu());
          SmartDialog.dismiss();
        }
        SmartDialog.dismiss();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${e.toString()} '),
        ),
      );
      SmartDialog.dismiss();
    }
  }
}
