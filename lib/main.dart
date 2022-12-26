import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sra_qatra/res/app_colors.dart';
import 'package:sra_qatra/routes/routes.dart';
import 'package:sra_qatra/routes/routes_name.dart';
import 'package:sra_qatra/screens/blood_request_screen.dart';
import 'package:sra_qatra/screens/history_screen.dart';
import 'package:sra_qatra/screens/home_screen.dart';
import 'package:sra_qatra/screens/imran.dart';
import 'package:sra_qatra/screens/intro_screen.dart';
import 'package:sra_qatra/screens/landing_screen.dart';
import 'package:sra_qatra/screens/no_internet_screen.dart';
import 'package:sra_qatra/screens/signin_screen.dart';
import 'package:sra_qatra/screens/signup_screen.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

bool show = true;
dynamic prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  Connectivity connection = Connectivity();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // checkConnection();

    show = prefs.getBool('ON_BOARDING') ?? true;
    return ChangeNotifierProvider<DropdownProvider>(
      create: (context) => DropdownProvider(),
      child: MaterialApp(
          color: AppColors.redColor,
          debugShowCheckedModeBanner: false,
          title: 'Blood Portal',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          onGenerateRoute: Routes.generateRoute,
          home: StreamBuilder(
            stream: connection.onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final state = snapshot.data;

                return show
                    ? const IntroScreen()
                    : StreamBuilder(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            return LandingScreen();
                          } else {
                            return SigninScreen();
                          }
                        });
              } else {
                return NoInternetScreen();
              }
            },
          )),
    );
  }

  void checkConnection() async {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {}
  }
}
