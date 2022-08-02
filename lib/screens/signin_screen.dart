import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/screens/landing_screen.dart';
import 'package:sra_qatra/screens/signup_screen.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/email_password_auth.dart';
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
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromRGBO(244, 66, 54, 1),
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
                              .signIn(emailControler.text, passControler.text)
                              .then((value) {
                            dialog.dismiss();
                            displaySnackbar(value);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(244, 66, 54, 1)),
                      child: const Text("SignIn"),
                    )),
                    SizedBox(
                      height: Dimension.height50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'create account?',
                          style:
                              TextStyle(color: Color.fromRGBO(244, 66, 54, 1)),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignupScreen()));
                            },
                            child: const Text(
                              'Signup',
                              style: TextStyle(
                                  color: Color.fromRGBO(244, 66, 54, 1)),
                            ))
                      ],
                    )
                  ],
                )),
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
