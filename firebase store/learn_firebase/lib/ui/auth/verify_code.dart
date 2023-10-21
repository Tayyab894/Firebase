import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/ui/posts/post_screen.dart';
import 'package:learn_firebase/utils/utility.dart';
import 'package:learn_firebase/widgets/round_button.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<VerifyCode> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Verify',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 40),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneNumberController,
              decoration: const InputDecoration(hintText: "Enter 6 Digits Code"),
            ),
            const SizedBox(height: 45),
            RoundButton(
                title: "Verify",
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final crendital = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: phoneNumberController.text.toString());

                   try {
                    await auth.signInWithCredential(crendital);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().ToastMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
