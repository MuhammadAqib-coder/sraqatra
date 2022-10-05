import 'package:flutter/material.dart';
import 'package:sra_qatra/services/email_password_auth.dart';
import 'package:sra_qatra/utils/utils.dart';
import 'package:sra_qatra/widgets/custom_text.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailControler = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme:
            const IconThemeData(color: const Color.fromRGBO(244, 66, 54, 1)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
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
                  if (_formKey.currentState!.validate()) {
                    String value = await EmailPasswordAuth()
                        .resetPassword(emailControler.text.trim());
                    Utils.displaySnackbar(value, context);
                  }
                },
                child: CustomText(text: 'Reset Password'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
