import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/models/donors_model.dart';
import 'package:sra_qatra/screens/history_screen.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/location_service.dart';
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
  late final searchControler;
  List<DonorsModel> donorsList = [];
  List<DonorsModel> donorsSearchList = [];
  late var provider;
  //late DocumentSnapshot documentSnapshot;
  Position? position;
  double? lat, lng;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchControler = TextEditingController();
  }

  Future<List<DonorsModel>> sortDonorlist() async {
    position = await LocationService.determinePosition();
    lat = position!.latitude;
    lng = position!.longitude;
    await FirebaseFirestore.instance.collection('donors').get().then((value) {
      //var list = value.docs;
      for (var i = 0; i < value.docs.length; i++) {
        donorsList.add(DonorsModel.fromJson(value.docs[i]));
        DonorsModel model = donorsList[i];
        model.distance = calculateDistance(lat, lng, model.lat, model.lng);
      }
      // for (DonorsModel model in donorsList) {
      //   model.distance = calculateDistance(lat, lng, model.lat, model.lng);
      // }
      donorsList.sort((a, b) {
        return b.distance!.compareTo(a.distance!);
      });
    });
    //setState(() {});
    return donorsList;
  }

  Future<List<DonorsModel>> searchDonorsList(String search) async {
    await FirebaseFirestore.instance
        .collection('donors')
        .where('blood_group', isEqualTo: search)
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        donorsSearchList.add(DonorsModel.fromJson(value.docs[i]));
      }
      //setState(() {});
    });
    return donorsSearchList;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DropdownProvider>(
      create: (context) => DropdownProvider(),
      child: Consumer<DropdownProvider>(
        builder: (_, value, child) {
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
                    TextButton.icon(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        label: CustomText(
                          text: 'Logout',
                        )),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => HistoryScreen()));
                        },
                        icon: const Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                        label: CustomText(
                          text: 'History',
                        ))
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
                  child: UpperPart(
                    model: value,
                    searchControler: searchControler,
                  ),
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
                    child: FutureBuilder<List<DonorsModel>>(
                  future: value.search.isEmpty
                      ? sortDonorlist()
                      : searchDonorsList(value.search),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return CustomContainer(
                            checkName: true,
                            location: snapshot.data![index].location,
                            bloodGroup: snapshot.data![index].bloodGroup,
                            name: snapshot.data![index].name,
                            gender: snapshot.data![index].gender,
                            number: snapshot.data![index].phone,
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(244, 66, 54, 1),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ))
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
        },
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

class UpperPart extends StatelessWidget {
  UpperPart({Key? key, required this.searchControler, required this.model})
      : super(key: key);
  // var searchControler = TextEditingController();
  final TextEditingController searchControler;
  final _formKey = GlobalKey<FormState>();
  DropdownProvider model;

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
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      icon: Icons.bloodtype,
                      labelText: "blood type",
                      controller: searchControler,
                      type: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: Dimension.height30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        model.setSearch(
                            searchControler.text.toUpperCase().trim());
                        _formKey.currentState!.reset();
                      }
                    },
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
