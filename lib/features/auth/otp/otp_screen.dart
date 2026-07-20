import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../permissions/location_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

final List<TextEditingController> controllers =
List.generate(6, (_) => TextEditingController());

final List<FocusNode> focusNodes =
List.generate(6, (_) => FocusNode());

bool canVerify = false;

@override
void dispose() {
for (final controller in controllers) {
controller.dispose();
}

for (final node in focusNodes) {
node.dispose();
}

super.dispose();
}

void checkOtp() {
final otp =
controllers.map((e) => e.text).join();

setState(() {
canVerify = otp.length == 6;
});
}

void moveNext(int index, String value) {

if (value.isNotEmpty && index < 5) {
FocusScope.of(context)
.requestFocus(focusNodes[index + 1]);
}

checkOtp();
}

void movePrevious(int index) {

if (index > 0) {
FocusScope.of(context)
.requestFocus(focusNodes[index - 1]);
}

checkOtp();
}

@override
Widget build(BuildContext context) {

return Scaffold(
backgroundColor: Colors.white,

body: SafeArea(
child: Padding(
padding:
const EdgeInsets.symmetric(horizontal: 30),

child: Column(
children: [

const SizedBox(height: 50),

Image.asset(
"assets/branding/logo_main.png",
width: 170,
),

const SizedBox(height: 35),

const Text(
"Verify Your Number",
style: TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 10),

const Text(
"We've sent a 6-digit code to your phone number.",
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.grey,
fontSize: 16,
),
),

const SizedBox(height: 45),

Row(
mainAxisAlignment:
MainAxisAlignment.spaceBetween,

children: List.generate(
6,
(index) {
return SizedBox(
width: 48,
height: 60,

child: TextField(
controller: controllers[index],
focusNode: focusNodes[index],

keyboardType:
TextInputType.number,

textAlign: TextAlign.center,

maxLength: 1,

inputFormatters: [
FilteringTextInputFormatter
.digitsOnly,
],

decoration: InputDecoration(
counterText: "",

filled: true,

fillColor:
const Color(0xFFF8F8F8),

enabledBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(14),

borderSide:
const BorderSide(
color:
Color(0xFFE5E5E5),
),
),

focusedBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(14),

borderSide:
const BorderSide(
color:
Color(0xFFF57C00),
width: 2,
),
),
),

onChanged: (value) {
moveNext(index, value);
},

onTap: () {
controllers[index]
.selection =
TextSelection.fromPosition(
TextPosition(
offset: controllers[index]
.text
.length,
),
);
},
  onSubmitted: (_) {
  checkOtp();
},

  onEditingComplete: () {
    checkOtp();
  },
),
);
},
),
),

  const SizedBox(height: 35),

  const Text(
    "Didn't receive the code?",
    style: TextStyle(
      color: Colors.grey,
    ),
  ),

  TextButton(
    onPressed: () {
      // TODO: Resend OTP
    },
    child: const Text(
      "Resend Code (00:59)",
      style: TextStyle(
        color: Color(0xFFF57C00),
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  const SizedBox(height: 30),

  SizedBox(
    width: double.infinity,
    height: 58,
    child: ElevatedButton(
      onPressed: canVerify
          ? () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const LocationScreen(),
          ),
        );
      }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor:
        const Color(0xFFF57C00),
        disabledBackgroundColor:
        Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(16),
        ),
      ),
      child: const Text(
        "VERIFY",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

  const Spacer(),

  TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: const Text(
      "← Back",
      style: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
    ),
  ),

  const SizedBox(height: 20),
],
),
),
),
);
}
}