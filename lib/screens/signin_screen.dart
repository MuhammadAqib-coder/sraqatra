//snackbar not show properly due to progressDialog

import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/screens/signup_screen.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/email_password_auth.dart';
import 'package:sra_qatra/widgets/custom_text.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final email_pass = EmailPasswordAuth();
  final emailControler = TextEditingController();
  final passControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return DropdownProvider();
    }, child: Consumer<DropdownProvider>(
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimension.width50,
                            right: Dimension.width50,
                            bottom: Dimension.height10),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimension.height20),
                          child: Image.asset(
                            'assets/images/main_blood_pic.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimension.height10,
                      ),
                      CustomTextField(
                        icon: Icons.email_outlined,
                        labelText: 'email',
                        controller: emailControler,
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: Dimension.height10,
                      ),
                      CustomTextField(
                        icon: model.password
                            ? Icons.visibility_off
                            : Icons.visibility,
                        textObsecure: model.password,
                        labelText: 'password',
                        controller: passControler,
                        onPressed: () {
                          model.setPassword(!model.password);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimension.width20),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'forget password?',
                              style: TextStyle(
                                  color: Color.fromRGBO(244, 66, 54, 1)),
                            )),
                      ),
                      SizedBox(
                        height: Dimension.height20,
                      ),
                      Center(
                          child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ProgressDialog dialog = ProgressDialog(context,
                                title: const Text('signin'),
                                message: const Text('please wait...'));
                            dialog.show();
                            await email_pass
                                .signIn(emailControler.text.trim(), passControler.text.trim())
                                .then((value) {
                              dialog.dismiss();
                              displaySnackbar(value);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(244, 66, 54, 1)),
                        child: CustomText(text: 'SignIn'),
                      )),
                      SizedBox(
                        height: Dimension.height50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'create account?',
                            color: const Color.fromRGBO(244, 66, 54, 1),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const SignupScreen()));
                              },
                              child: CustomText(
                                text: 'SignUp',
                                color: const Color.fromRGBO(244, 66, 54, 1),
                              ))
                        ],
                      )
                    ],
                  )),
            ),
          ),
        );
      },
    ));
  }

  void displaySnackbar(messege) async {
    var snackBar = SnackBar(content: Text(messege));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
