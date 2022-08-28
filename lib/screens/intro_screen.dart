import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sra_qatra/screens/signin_screen.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/widgets/custom_text.dart';
import 'package:sra_qatra/widgets/next_container.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
              image: ClipRRect(
                borderRadius: BorderRadius.circular(Dimension.height10),
                child: Image.asset(
                  'assets/images/main_blood_pic.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              decoration: PageDecoration(
                  bodyTextStyle: TextStyle(
                      color: const Color.fromRGBO(244, 66, 54, 1),
                      fontSize: Dimension.height16),
                  titleTextStyle: TextStyle(
                      color: const Color.fromRGBO(244, 66, 54, 1),
                      fontSize: Dimension.height20,
                      fontWeight: FontWeight.bold),
                  imagePadding: EdgeInsets.only(top: Dimension.height40)),
              title: 'First Page',
              body: 'Online Blood Collection and Donation Portal'),
          PageViewModel(
              image: ClipRRect(
                borderRadius: BorderRadius.circular(Dimension.height10),
                child: Image.asset(
                  'assets/images/blood_accepter.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              title: 'Second Page',
              decoration: PageDecoration(
                  bodyTextStyle: TextStyle(
                      color: const Color.fromRGBO(244, 66, 54, 1),
                      fontSize: Dimension.height16),
                  titleTextStyle: TextStyle(
                      color: const Color.fromRGBO(244, 66, 54, 1),
                      fontSize: Dimension.height20,
                      fontWeight: FontWeight.bold),
                  imagePadding: EdgeInsets.only(top: Dimension.height40)),
              body:
                  'you can donate blood to save some precious life. Only one donation history at a time'),
          PageViewModel(
              image: ClipRRect(
                borderRadius: BorderRadius.circular(Dimension.height10),
                child: Image.asset(
                  'assets/images/blood_donor.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              decoration: PageDecoration(
                  titleTextStyle: TextStyle(
                      color: const Color.fromRGBO(244, 66, 54, 1),
                      fontSize: Dimension.height20,
                      fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(
                      color: const Color.fromRGBO(244, 66, 54, 1),
                      fontSize: Dimension.height16),
                      imagePadding: EdgeInsets.only(top: Dimension.height40)),
              title: 'Third Page',
              body:
                  'You can accept blood from this app. You can only one request for blood')
        ],
        dotsDecorator: const DotsDecorator(
          activeColor: Color.fromRGBO(244, 66, 54, 1),
          activeSize: Size.square(13),
        ),
        next: const NextContainer(
          icon: Icons.subdirectory_arrow_right,
        ),
        showNextButton: true,
        showBackButton: false,
        //back: const Icon(Icons.arrow_back),
        skip: CustomText(
            text: 'skip',
            color: const Color.fromRGBO(244, 66, 54, 1),
            fontSize: Dimension.height16),
        showSkipButton: true,
        done: CustomText(
          text: 'Done',
          color: const Color.fromRGBO(244, 66, 54, 1),
          fontSize: Dimension.height16,
        ),
        showDoneButton: true,
        onDone: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('ON_BOARDING', true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => SigninScreen()));
        },
      ),
    );
  }
}
