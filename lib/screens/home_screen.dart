import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/screens/donation_screen.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/widgets/custom_text.dart';

import '../widgets/custom_container.dart';
import '../widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //late DropdownProvider provider;

  @override
  Widget build(BuildContext context) {
    //provider = Provider.of<DropdownProvider>(context);

    // print(Dimension.screenHeight);
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: provider.currentIndex,
      //   onTap: (index) {
      //     provider.setCurrentIndex(index);
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.bloodtype,
      //           color: Colors.white,
      //         ),
      //         label: "Donors"),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home,
      //           color: Colors.white,
      //         ),
      //         label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.bloodtype,
      //           color: Colors.white,
      //         ),
      //         label: "Accepters")
      //   ],
      // ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
        child: DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: Dimension.height50,
                backgroundColor: Colors.white,
              ),
              SizedBox(
                height: Dimension.height20,
              ),
              CustomText(text: FirebaseAuth.instance.currentUser!.email!),
              SizedBox(
                height: Dimension.height10,
              ),
              const Divider(
                color: Colors.white,
                // indent: 10,
                // endIndent: 10,
                thickness: 2,
              ),
              SizedBox(
                height: Dimension.height20,
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Row(
                  children: [
                    const CustomText(text: 'logout'),
                    SizedBox(
                      width: Dimension.width5,
                    ),
                    const Icon(
                      Icons.logout,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: UpperPart(),
          ),
          SizedBox(
            height: Dimension.height20,
          ),
          Padding(
            padding: EdgeInsets.all(Dimension.height8),
            child: Text(
              'recommended donors',
              style: TextStyle(fontSize: Dimension.height18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return CustomContainer(
                  location: "islamabad",
                  bloodGroup: "AB+",
                  name: "Muhammad Aqib",
                  gender: "Male",
                  number: "0234567890",
                  onPressed: () {},
                );
              },
            ),
          )
        ],
      ),

      //floating actiion button

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (_) => DonationScreen()));
      //   },
      //   label: Text(
      //     "Be Donor",
      //     style: TextStyle(fontSize: Dimension.height16),
      //   ),
      //   icon: const Icon(Icons.add),
      //   backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
      // ),
    );
  }
}

class UpperPart extends StatelessWidget {
  UpperPart({Key? key}) : super(key: key);
  var bloodControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          decoration: BoxDecoration(color: Color.fromRGBO(244, 66, 54, 1)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.only(
                  top: Dimension.height10, bottom: Dimension.height10),
              margin: EdgeInsets.only(
                  left: Dimension.width25, right: Dimension.width25),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 240, 231, 231),
                        blurRadius: 5,
                        offset: Offset(0, 5)),
                    BoxShadow(
                        //blurRadius: 5,
                        color: Colors.white,
                        offset: Offset(-5, 0)),
                    BoxShadow(
                        //blurRadius: 5,
                        color: Colors.white,
                        offset: Offset(5, 0))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimension.height10)),
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              child: Column(
                children: [
                  CustomTextField(
                    icon: Icons.bloodtype,
                    labelText: "blood type",
                    controller: bloodControler,
                  ),
                  SizedBox(
                    height: Dimension.height30,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(244, 66, 54, 1),
                    ),
                    child: Text(
                      'search',
                      style: TextStyle(fontSize: Dimension.height16),
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
