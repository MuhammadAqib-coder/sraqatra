import 'package:flutter/material.dart';
import 'package:sra_qatra/services/email_password_auth.dart';
import 'package:sra_qatra/widgets/custom_text.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            icon: Icons.email,
            labelText: 'Email',
            onPressed: () {},
            controller: emailControler,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: ElevatedButton(
              onPressed: () async {
                String value = await EmailPasswordAuth()
                    .resetPassword(emailControler.text.trim());
                displaySnackbar(value);
              },
              child: CustomText(text: 'Reset Password'),
            ),
          )
        ],
      ),
    );
  }

  void displaySnackbar(value) {
    var snackBar = SnackBar(content: Text(value));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
