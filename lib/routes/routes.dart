import 'package:flutter/material.dart';
import 'package:sra_qatra/main.dart';
import 'package:sra_qatra/routes/routes_name.dart';
import 'package:sra_qatra/screens/intro_screen.dart';
import 'package:sra_qatra/screens/signin_screen.dart';
import 'package:sra_qatra/screens/signup_screen.dart';

import '../screens/blood_request_screen.dart';
import '../screens/donation_screen.dart';
import '../screens/history_screen.dart';
import '../screens/home_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/request_blood_screen.dart';
import '../screens/reset_password_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.introScreen:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case RoutesName.signinScreen:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case RoutesName.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case RoutesName.landingScreen:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RoutesName.donationScreen:
        
        return MaterialPageRoute(builder: (_) => DonationScreen());
      case RoutesName.requestBloodScreen:
        return MaterialPageRoute(builder: (_) => RequestBloodScreen());
      case RoutesName.bloodRequestScreen:
        return MaterialPageRoute(builder: (_) => const BloodRequestScreen());
      case RoutesName.historyScreen:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      case RoutesName.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
        case RoutesName.myApp:
        return MaterialPageRoute(builder: (_) => const MyApp());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('No Route found'),
                  ),
                ));
    }
  }
}
