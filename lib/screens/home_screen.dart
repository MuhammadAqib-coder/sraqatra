import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/models/donors_model.dart';
import 'package:sra_qatra/res/app_colors.dart';
import 'package:sra_qatra/routes/routes_name.dart';
import 'package:sra_qatra/screens/history_screen.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/location_service.dart';
import 'package:sra_qatra/widgets/custom_text.dart';

import '../res/components/homepage_upper_part.dart';
import '../utils/utils.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //late DropdownProvider provider;
  late TextEditingController searchControler;
  List<DonorsModel> donorsSearchList = [];
  //late var provider;
  //late DocumentSnapshot documentSnapshot;
  Position? position;
  double? lat, lng;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchControler = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DropdownProvider>(context, listen: false).setSearch('');
    });
  }

  Future<List<DonorsModel>> sortDonorlist() async {
    List<DonorsModel> donorsList = [];

    position = await LocationService.determinePosition();
    lat = position!.latitude;
    lng = position!.longitude;
    await FirebaseFirestore.instance.collection('donors').get().then((value) {
      //var list = value.docs;
      for (var i = 0; i < value.docs.length; i++) {
        donorsList.add(DonorsModel.fromJson(value.docs[i]));
        DonorsModel model = donorsList[i];
        model.distance =
            Utils.calculateDistance(lat, lng, model.lat, model.lng);
      }
      // for (DonorsModel model in donorsList) {
      //   model.distance = calculateDistance(lat, lng, model.lat, model.lng);
      // }
    });
    if (donorsList.length > 1) {
      donorsList.sort((a, b) {
        return a.distance!.compareTo(b.distance!);
      });
    }
    //setState(() {});
    return donorsList;
  }

// list of search donors (first logic that i apply on filtering list)

  // Future<List<DonorsModel>> searchDonorsList(String search) async {
  //   await FirebaseFirestore.instance
  //       .collection('donors')
  //       .where('blood_group', isEqualTo: search)
  //       .get()
  //       .then((value) {
  //     for (int i = 0; i < value.docs.length; i++) {
  //       donorsSearchList.add(DonorsModel.fromJson(value.docs[i]));
  //     }
  //     //setState(() {});
  //   });
  //   return donorsSearchList;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
          backgroundColor: AppColors.redColor,
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
                  color: AppColors.whiteColor,
                  // indent: 10,
                  // endIndent: 10,
                  thickness: 2,
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                TextButton.icon(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: AppColors.whiteColor,
                    ),
                    label: CustomText(
                      text: 'Logout',
                    )),
                TextButton.icon(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                          context, RoutesName.historyScreen);
                    },
                    icon: const Icon(
                      Icons.history,
                      color: AppColors.whiteColor,
                    ),
                    label: CustomText(
                      text: 'History',
                    ))
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Donors'),
          backgroundColor: AppColors.redColor,
          elevation: 0,
        ),
        body: Consumer<DropdownProvider>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.3,
                //   child: UpperPart(
                //     model: value,
                //     searchControler: searchControler,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchControler,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'enter blood group',
                        hintStyle: TextStyle(color: AppColors.redColor),
                        suffixIcon: Icon(
                          Icons.bloodtype,
                          color: AppColors.redColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: AppColors.redColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: AppColors.redColor))),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  height: Dimension.height10,
                ),
                Padding(
                    padding: EdgeInsets.all(Dimension.height8),
                    child: CustomText(
                      text: 'recommended donors',
                      color: AppColors.redColor,
                      fontSize: Dimension.height18,
                    )),
                Expanded(
                    child: FutureBuilder<List<dynamic>>(
                  future: sortDonorlist(), //value.search.isEmpty
                  // ? sortDonorlist()
                  // : searchDonorsList(value.search),
                  builder: (_, snapshot) {
                    int count = 0;
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var group = snapshot.data![index].bloodGroup;
                          if (searchControler.text.isEmpty) {
                            //value.search.isEpmty
                            return CustomContainer(
                              checkName: true,
                              location: snapshot.data![index].location,
                              bloodGroup: snapshot.data![index].bloodGroup,
                              name: snapshot.data![index].name,
                              gender: snapshot.data![index].gender,
                              number: snapshot.data![index].phone,
                            );
                          } else if (group
                              .toLowerCase()
                              .contains(searchControler.text.trim())) {
                            //value.search.toLowerCase
                            //count++;
                            // if (index == snapshot.data!.length) {
                            //   value.setSearch('');
                            // }
                            return CustomContainer(
                              checkName: true,
                              location: snapshot.data![index].location,
                              bloodGroup: snapshot.data![index].bloodGroup,
                              name: snapshot.data![index].name,
                              gender: snapshot.data![index].gender,
                              number: snapshot.data![index].phone,
                            );
                          } else {
                            //value.setSearch('');
                            return
                                //count > 0
                                //     ? Padding(
                                //         padding: EdgeInsets.all(Dimension.height50),
                                //         child: Center(
                                //           child: CustomText(
                                //             text: 'Opps no donor found',
                                //             color: AppColors.redColor,
                                //             fontSize: Dimension.height20,
                                //           ),
                                //         ),
                                //       )
                                //     :
                                Container();
                          }
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.redColor,
                        ),
                      );
                    } else if (snapshot.data == null &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Center(
                        child: CustomText(text: 'No Record Found'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.redColor,
                        ),
                      );
                    }
                  },
                ))
              ],
            );
          },
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
