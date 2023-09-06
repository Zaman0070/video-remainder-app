import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

final twilioProvider = Provider<TwilioFlutter>((ref) {
  const accountSid = 'AC27af0ae086eb1b7d0d67f8215c98ad93';
  const authToken = 'f403e4f5be32befc928a88474e24465b';
  return TwilioFlutter(
    accountSid: accountSid,
    authToken: authToken,
    twilioNumber: '+14155238886',
  );
});

final sendMessageProvider = FutureProvider<void>((ref) async {
  final twilio = ref.read(twilioProvider);
  await twilio.sendWhatsApp(
    messageBody: 'ff',
    toNumber: "+923044410007",
  );
});
