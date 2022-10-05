//the textformfiield is not clear on _formkey.currentState.reset();

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/res/app_colors.dart';
import 'package:sra_qatra/routes/routes_name.dart';
import 'package:sra_qatra/screens/signin_screen.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/email_password_auth.dart';
import 'package:sra_qatra/widgets/custom_text.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

import '../services/dimension.dart';
import '../utils/utils.dart';

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
            backgroundColor: AppColors.redColor,
            title: CustomText(text: 'SignUp'),
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
                              // ignore: use_build_context_synchronously
                             // Navigator.pop(context);

                              //_fromKey.currentState!.reset();
                              emailControler.text = '';
                              passControler.text = '';
                              conPassControler.text = '';
                              nameControler.text = '';
                              fnameControler.text = '';
                              locControler.text = '';
                              dialog.dismiss();
                              // ignore: use_build_context_synchronously
                              Utils.displaySnackbar(value, context);
                            } else {
                              Utils.displaySnackbar(
                                  'password not match', context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.redColor),
                        child: CustomText(text: 'submit'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Already have an Account?',
                            color: AppColors.redColor,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, RoutesName.signinScreen);
                              },
                              child: CustomText(
                                text: 'SignIn',
                                color: AppColors.redColor,
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
}
