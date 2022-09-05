import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/screens/blood_request_screen.dart';
import 'package:sra_qatra/screens/donation_screen.dart';
import 'package:sra_qatra/screens/home_screen.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';

import '../services/dimension.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final pages =  [BloodRequestScreen(), HomeScreen(), DonationScreen()];
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<DropdownProvider>(context);
    return ChangeNotifierProvider(
      create: (context) {
        return DropdownProvider();
      },
      child: Consumer<DropdownProvider>(
        builder: ((context, value, child) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: const Color.fromRGBO(244, 66, 54, 1),
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
      ),
    );
  }
}
