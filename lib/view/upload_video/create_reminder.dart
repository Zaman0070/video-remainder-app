// ignore_for_file: library_private_types_in_public_api
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/app_button.dart';
import 'package:reminder_app/constant/widget/catch_image.dart';
import 'package:reminder_app/constant/widget/common_textfield.dart';
import 'package:reminder_app/constant/widget/loadingWidget.dart';
import 'package:reminder_app/models/user.dart';
import 'package:reminder_app/services/firebase_services/firebase_services.dart';
import 'package:reminder_app/services/one_signal/one_signal.dart';
import 'package:reminder_app/view/upload_video/widgets/reminder_card.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class CreateRemainder extends ConsumerStatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final String title;
  final String description;
  const CreateRemainder(
      {super.key,
      required this.videoUrl,
      required this.thumbnailUrl,
      required this.title,
      required this.description});

  @override
  ConsumerState<CreateRemainder> createState() => _CreateRemainderState();
}

class _CreateRemainderState extends ConsumerState<CreateRemainder> {
  DateTime selectedDate = DateTime.now();
  DateTime scheduleTime = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: 'AC418b336caf877e0c18f5101f128bf387',
      authToken: '3a22440c3fc6bc007462634ce690f31c',
      twilioNumber: '+14155238886');

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        scheduleTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
          scheduleTime.second,
        );
        print(scheduleTime);
      });
    }
  }

  var controller = TextEditingController();
  var categoryController = TextEditingController();
  String category = '';
  int selctIndex = 0;
  FirebaseServices firebaseServices = FirebaseServices();

  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC418b336caf877e0c18f5101f128bf387',
        authToken: '3a22440c3fc6bc007462634ce690f31c',
        twilioNumber: '14155238886');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Create Remainder',
            style: TextStyle(color: appColor, fontSize: 17.sp)),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 20),
            child: InkWell(
              onTap: () {},
              child: Text('Skip to save',
                  style: TextStyle(
                    color: Colors.greenAccent[700],
                    fontSize: 13.sp,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Create New\nReminder',
                style: TextStyle(
                    color: appColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              CommonTextField(
                controller: controller,
                hintText: 'Enter Receiver WhatsApp Number + Country Code',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 40,
              ),
              RemainderCard(
                onTap: () {
                  _selectDate(context);
                },
                image: AppImage.calender,
                title: DateFormat('EE, yyyy MMM').format(selectedDate),
              ),
              const SizedBox(
                height: 20,
              ),
              RemainderCard(
                onTap: () {
                  _selectTime(context);
                },
                image: AppImage.clock,
                title: selectedTime.format(context),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Category',
                style: TextStyle(
                    color: appColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('category')
                      .doc('category')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!['category'].length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisExtent: 30.h,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          if (index == snapshot.data!['category'].length) {
                            return InkWell(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddCategoryDialog(
                                      categoryController: categoryController,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: grey3, width: 0.4),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color(0xff26CBFF).withOpacity(0.25),
                                      const Color(0xff6980FD).withOpacity(0.25),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurStyle: BlurStyle.outer,
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: const Offset(0, 0),
                                    )
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      color: black,
                                      size: 15,
                                    ),
                                    Text(
                                      'New',
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () {
                              setState(() {
                                category = snapshot.data!['category'][index];
                                selctIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: grey3, width: 0.4),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    selctIndex == index
                                        ? appColor
                                        : const Color(0xff26CBFF)
                                            .withOpacity(0.25),
                                    selctIndex == index
                                        ? appColor
                                        : const Color(0xff6980FD)
                                            .withOpacity(0.25),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: const Offset(0, 0),
                                  )
                                ],
                              ),
                              child: Center(
                                  child: Text(
                                snapshot.data!['category'][index],
                                style: TextStyle(
                                    color: selctIndex == index ? white : black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          );
                        });
                  }),
              const SizedBox(
                height: 80,
              ),
              AppButton(
                  text: 'Upload',
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UserListDialog(
                          title: widget.title,
                        );
                      },
                    );

                    //     .whenComplete(() {
                    //   Future.delayed(const Duration(seconds: 15), () async {
                    //     ref.read(sendMessageProvider);
                    //   });
                    // });
                    // ref.read(sendMessageProvider);
                    // Workmanager().registerOneOffTask(uinqId, task,
                    //     initialDelay: Duration(
                    //         seconds: scheduleTime
                    //             .difference(DateTime.now())
                    //             .inSeconds),
                    //     constraints:
                    //         Constraints(networkType: NetworkType.connected),
                    //     inputData: <String, dynamic>{
                    //       'url': widget.videoUrl,
                    //       'toNumber': controller.text,
                    //     });

                    // await firebaseServices.uploadVideo(
                    //     data: VideoModel(
                    //   uid: FirebaseAuth.instance.currentUser!.uid,
                    //   reminderTitle: controller.text,
                    //   videoUrl: widget.videoUrl,
                    //   videoThumbnailUrl: widget.thumbnailUrl,
                    //   title: widget.title,
                    //   description: widget.description,
                    //   category: category,
                    //   remainderDate:
                    //       selectedDate.millisecondsSinceEpoch.toString(),
                    //   time: DateTime.now().millisecondsSinceEpoch.toString(),
                    //   remainderTime: selectedTime.format(context),
                    // ));
                  })
            ],
          ),
        ),
      ),
    );
  }

  void sendMsg() async {
    // const accountSid = 'AC418b336caf877e0c18f5101f128bf387';
    const accountSid = 'AC26073bd81df50a7bb92e5bc071d3fb74';
    // const authToken = '3a22440c3fc6bc007462634ce690f31c';
    const authToken = '788f2c7b56be4dda063bf7da80ef0809';
    final twilio = TwilioFlutter(
        accountSid: accountSid,
        authToken: authToken,
        twilioNumber: '+14155238886');
    final message = await twilio.sendWhatsApp(
        messageBody: 'nnjnjbj', toNumber: "+923044410007");
    print(message);
  }
}

class AddCategoryDialog extends StatefulWidget {
  final TextEditingController categoryController;

  const AddCategoryDialog({super.key, required this.categoryController});

  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Category'),
      content: TextField(
        style: const TextStyle(color: black),
        controller: widget.categoryController,
        decoration: const InputDecoration(
          labelText: 'Category Name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          style:
              ButtonStyle(backgroundColor: MaterialStateProperty.all(appColor)),
          onPressed: () async {
            await firebaseServices
                .addCategoryEng(
                    categoryText: widget.categoryController.text,
                    context: context)
                .whenComplete(() {
              Navigator.pop(context);
            });
            // Close the dialog
          },
          child: const Text('Add Category'),
        ),
      ],
    );
  }
}

class UserListDialog extends StatefulWidget {
  final String title;
  const UserListDialog({super.key, required this.title});

  @override
  _UserListDialogState createState() => _UserListDialogState();
}

class _UserListDialogState extends State<UserListDialog> {
  FirebaseServices firebaseServices = FirebaseServices();

  List<int> selectedItems = [];
  OneSignals oneSignal = OneSignals();
  List tokenIdList = [];
  String name = '';

  getCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      UserModel userModel = UserModel.fromMap(value.data()!);
      name = userModel.userName as String;
      setState(() {});
    });
  }

  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'User Lists',
        style: TextStyle(color: Colors.black),
      ),
      content: SizedBox(
        height: 350.h,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid',
                    isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LoadingWidget(color: appColor);
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  UserModel userModel =
                      UserModel.fromMap(snapshot.data!.docs[index].data());
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: CachedRectangularNetworkImageWidget(
                      radius: 30,
                      image: userModel.userImage as String,
                      width: 35.h,
                      height: 30.h,
                    ),
                    title: Text(
                      userModel.userName as String,
                      style: TextStyle(
                          color: black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedItems.contains(index)) {
                            selectedItems.remove(index);
                          } else {
                            selectedItems.add(index);
                          }
                        });
                        print(widget.title);
                        tokenIdList.add(userModel.token!);
                        print(tokenIdList.first);
                      },
                      child: Container(
                        height: 16.h,
                        width: 16.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: appColor, width: 1.5),
                        ),
                        child: Icon(
                          Icons.check,
                          color: selectedItems.contains(index)
                              ? appColor
                              : Colors.transparent,
                          size: 12.h,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      actions: [
        ElevatedButton(
          style:
              ButtonStyle(backgroundColor: MaterialStateProperty.all(appColor)),
          onPressed: () async {
            await oneSignal
                .sendNotification(
              tokenIdList,
              name,
              widget.title,
              AppImage.logo,
            )
                .whenComplete(() {
              Navigator.pop(context);
            });
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}
