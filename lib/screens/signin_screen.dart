//snackbar not show properly due to progressDialog

import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/res/app_colors.dart';
import 'package:sra_qatra/routes/routes_name.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/email_password_auth.dart';
import 'package:sra_qatra/widgets/custom_text.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

import '../utils/utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailPass = EmailPasswordAuth();
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
            padding:  EdgeInsets.only(top: Dimension.height50),
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
                        icon: Icons.alternate_email,
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
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RoutesName.resetPasswordScreen);
                            },
                            child: const Text(
                              'forget password?',
                              style: TextStyle(
                                  color: AppColors.redColor),
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
                                defaultLoadingWidget:
                                    const CircularProgressIndicator(),
                                title: const Text('signin'),
                                message: const Text('please wait...'));
                            dialog.show();
                            await emailPass
                                .signIn(emailControler.text.trim(),
                                    passControler.text.trim())
                                .then((value) {
                              dialog.dismiss();
                              Utils.displaySnackbar(value, context);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.redColor),
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
                            color: AppColors.redColor,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RoutesName.signupScreen);
                              },
                              child: CustomText(
                                text: 'SignUp',
                                color: AppColors.redColor,
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
}
