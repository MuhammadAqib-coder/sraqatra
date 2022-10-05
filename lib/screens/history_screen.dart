import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sra_qatra/res/app_colors.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/widgets/custom_container.dart';
import 'package:sra_qatra/widgets/custom_text.dart';
import 'package:sra_qatra/widgets/delete_update.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Position? position;
  // double? lat, lng;
  // List<DonorsModel> donorsList = [];
  // late DonorsModel model;
  bool testDonor = false;
  bool testAccepter = false;
  // bool donorExist = false;
  // bool accepterExist = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseFirestore.instance
    //     .collection('donors')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     donorExist = true;
    //   }
    // });
    //getData('donors');
    //sortDonorlist();
  }

  // getData(value) async {
  //   if (value == 'donors') {
  //     await FirebaseFirestore.instance
  //         .collection(value)
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get()
  //         .then((DocumentSnapshot snapshot) {
  //       if (snapshot.exists) {
  //         donorExist = !donorExist;
  //         setState(() {
            
  //         });
  //       }
  //     });
  //   } else {
  //     await FirebaseFirestore.instance
  //         .collection(value)
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get()
  //         .then((DocumentSnapshot snapshot) {
  //       if (snapshot.exists) {
  //         accepterExist = !accepterExist;
  //         setState(() {
            
  //         });
  //       }
  //     });
  //   }
  //  // setState(() {});
  // }

  // Future<void> sortDonorlist() async {
  //   position = await LocationService.determinePosition();
  //   lat = position!.latitude;
  //   lng = position!.longitude;
  //   // AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot =
  //   //     FirebaseFirestore.instance.collection('donors').snapshots()
  //   //         as AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>;
  //   // var l = snapShot.data!.docs.length;
  //   // for (var i = 0; i < l; i++) {
  //   //   donorsList.add(DonorsModel.fromJson(snapShot.data!.docs[i]));
  //   // }
  //   await FirebaseFirestore.instance.collection('donors').get().then((value) {
  //     //var list = value.docs;
  //     for (var i = 0; i < value.docs.length; i++) {
  //       donorsList.add(DonorsModel.fromJson(value.docs[i]));
  //       DonorsModel model = donorsList[i];
  //       model.distance = calculateDistance(lat, lng, model.lat, model.lng);
  //     }
  //     // for (DonorsModel model in donorsList) {
  //     //   model.distance = calculateDistance(lat, lng, model.lat, model.lng);
  //     // }
  //     donorsList.sort((a, b) {
  //       return a.distance!.compareTo(b.distance!);
  //     });
  //   });

  //   setState(() {});
  // }

  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          centerTitle: true,
          backgroundColor: AppColors.redColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: 'Request as a Donor',
                fontSize: 18,
                color: AppColors.redColor,
              ),
              SizedBox(
                height: Dimension.height15,
              ),
              Row(
                children: [
                  Expanded(
                    
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('donors')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('something went wrong'),
                          );
                        } else if (snapshot.hasData && !snapshot.data!.exists) {
                          
                          return const Center(
                            child: Text('Document not exist'),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                       
                          return CustomContainer(
                            location: data['location'],
                            bloodGroup: data['blood_group'],
                            number: data['phone'],
                            checkName: true,
                            gender: data['gender'],
                            name: data['name'],
                          );
                        }
                      },
                    ),
                  ),
                      const DeleteAndUpdate(
                          collectionName: 'donors',
                        )
                ],
              ),
              SizedBox(
                height: Dimension.height10,
              ),
              CustomText(
                text: 'Request as an Accepter',
                color: AppColors.redColor,
                fontSize: 18,
              ),
              SizedBox(
                height: Dimension.height10,
              ),
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('accepters')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('something went wrong'),
                          );
                        } else if (snapshot.hasData && !snapshot.data!.exists) {
                          
                          return const Center(
                            child: Text('Document not exist'),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return CustomContainer(
                              bloodAmount: data['blood_amount'],
                              duration: data['duration'],
                              location: data['location']!,
                              bloodGroup: data['blood_group']!,
                              number: data['phone']!,
                              checkName: false);
                        }
                      },
                    ),
                  ),
                      const DeleteAndUpdate(
                          collectionName: 'accepters',
                        )
                ],
              )
            ],
          ),
        ));
  }
}
