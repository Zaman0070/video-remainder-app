import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:reminder_app/services/notifi_service/notifi_service.dart';
import 'package:reminder_app/services/notifi_service/shedule_msg.dart';
import 'package:reminder_app/view/splash_screen/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

const task = 'taskOne';
final callbackDispatcherProvider = Provider<void>((ref) {
  final sendMsg = ref.read(sendMessageProvider);
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case 'taskOne':
        print("Calling sendMsg");
        await sendMsg;
        break;
      default:
    }
    return Future.value(true).whenComplete(() => sendMsg);
  });
});

void callbackDispatcher() async {
  final container = ProviderContainer();
  container.read(callbackDispatcherProvider);
  container.dispose();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Firebase.initializeApp();
  NotificationService().initNotification();

  tz.initializeTimeZones();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(),
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        child: const SplashScreen());
  }
}
