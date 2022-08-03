//the textformfiield is not clear on _formkey.currentState.reset();

import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/screens/signin_screen.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/email_password_auth.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

import '../services/dimension.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _fromKey = GlobalKey<FormState>();
  final nameControler = TextEditingController();
  final fnameControler = TextEditingController();
  final emailControler = TextEditingController();
  final passControler = TextEditingController();
  final locControler = TextEditingController();
  final conPassControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return DropdownProvider();
    }, child: Consumer<DropdownProvider>(
      builder: ((context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
            title: const Text('SignUp'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: Dimension.height30),
              child: Form(
                  key: _fromKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        icon: Icons.account_circle_rounded,
                        labelText: 'name',
                        controller: nameControler,
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: Dimension.height10,
                      ),
                      CustomTextField(
                        icon: Icons.account_circle_rounded,
                        labelText: 'father name',
                        controller: fnameControler,
                        onPressed: () {},
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
                        textObsecure: model.password,
                        icon: model.password
                            ? Icons.visibility_off
                            : Icons.visibility,
                        labelText: 'password',
                        controller: passControler,
                        onPressed: () {
                          model.setPassword(!model.password);
                        },
                      ),
                      SizedBox(
                        height: Dimension.height10,
                      ),
                      CustomTextField(
                        textObsecure: model.confirmPass,
                        icon: model.confirmPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        labelText: 'confirm password',
                        controller: conPassControler,
                        onPressed: () {
                          model.setConfirmPass(!model.confirmPass);
                        },
                      ),
                      SizedBox(
                        height: Dimension.height10,
                      ),
                      CustomTextField(
                        icon: Icons.location_searching,
                        labelText: 'location',
                        controller: locControler,
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: Dimension.height20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_fromKey.currentState!.validate()) {
                            ProgressDialog dialog = ProgressDialog(context,
                                title: const Text('signUp'),
                                message: const Text('please wait...'));
                            if (passControler.text.trim() ==
                                conPassControler.text.trim()) {
                              dialog.show();
                              String value = await EmailPasswordAuth().signUp(
                                  emailControler.text.trim(),
                                  passControler.text.trim(),
                                  nameControler.text.trim(),
                                  fnameControler.text.trim(),
                                  locControler.text.trim());
                              //_fromKey.currentState!.reset();
                              emailControler.text = '';
                              passControler.text = '';
                              nameControler.text = '';
                              fnameControler.text = '';
                              locControler.text = '';
                              dialog.dismiss();
                              displaySnackbar(value);
                            } else {
                              displaySnackbar('password not match');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(244, 66, 54, 1)),
                        child: const Text('submit'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                                color: Color.fromRGBO(244, 66, 54, 1)),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const SigninScreen()));
                              },
                              child: const Text(
                                'SignIn',
                                style: TextStyle(
                                    color: Color.fromRGBO(244, 66, 54, 1)),
                              ))
                        ],
                      )
                    ],
                  )),
            ),
          ),
        );
      }),
    ));
  }

  void displaySnackbar(message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
