import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/screens/blood_request_screen.dart';
import 'package:sra_qatra/screens/donation_screen.dart';
import 'package:sra_qatra/screens/home_screen.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';

import '../res/app_colors.dart';
import '../services/dimension.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final pages =  [const BloodRequestScreen(), const HomeScreen(), DonationScreen()];
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<DropdownProvider>(context);
    return Consumer<DropdownProvider>(
      builder: ((context, value, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.redColor,
            selectedFontSize: Dimension.height16,
            currentIndex: value.currentIndex,
            onTap: (index) {
              value.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.bloodtype), label: "Accepters"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bloodtype), label: "Donor"),
            ],
          ),
          body: pages[value.currentIndex],
        );
      }),
    );
  }
}
