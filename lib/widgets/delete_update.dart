import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/res/app_colors.dart';
import 'package:sra_qatra/routes/routes_name.dart';
import 'package:sra_qatra/screens/donation_screen.dart';
import 'package:sra_qatra/screens/request_blood_screen.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';

import 'package:sra_qatra/widgets/custom_text.dart';

import '../services/dimension.dart';
import '../utils/utils.dart';

//problem in namedNavigation and argument through it

class DeleteAndUpdate extends StatefulWidget {
  const DeleteAndUpdate({
    Key? key,
    required this.collectionName,
  }) : super(key: key);
  final String collectionName;

  @override
  State<DeleteAndUpdate> createState() => _DeleteAndUpdateState();
}

class _DeleteAndUpdateState extends State<DeleteAndUpdate> {
  Map<String, dynamic>? map;
  //late var provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // provider = Provider.of<DropdownProvider>(context, listen: false);
    FirebaseFirestore.instance
        .collection(widget.collectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        map = snapshot.data() as Map<String, dynamic>;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(Dimension.height8)),
      child: Consumer<DropdownProvider>(
        builder: ((context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection(widget.collectionName)
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((DocumentSnapshot snapshot) {
                      if (snapshot.exists) {
                        if (widget.collectionName == 'donors') {
                          value.setBloodgroup(map!['blood_group']);
                          value.setGender(map!['gender']);
                          // Navigator.popAndPushNamed(
                          //     context, RoutesName.donationScreen,
                          //     arguments: map);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DonationScreen(
                                        map: map,
                                       provider: value,
                                      )));
                        } else {
                          value.setBloodgroup(map!['blood_group']);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RequestBloodScreen(
                                        map: map,
                                      )));
                        }
                      } else {
                        Utils.displaySnackbar('no document found', context);
                      }
                    });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.redColor,
                  )),
              SizedBox(
                height: Dimension.height10,
              ),
              IconButton(
                  onPressed: () async {
                    var dialogBox = AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection(widget.collectionName)
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .delete();
                              Navigator.pop(context);
                            },
                            child: CustomText(
                              text: 'Yes',
                              color: AppColors.redColor,
                              fontSize: Dimension.height16,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: CustomText(
                              fontSize: Dimension.height16,
                              text: 'No',
                              color: AppColors.redColor,
                            ))
                      ],
                      title: CustomText(
                        text: 'Confirmation',
                        color: AppColors.redColor,
                        fontSize: Dimension.height18,
                      ),
                      content: CustomText(
                        text: 'Do you want to delete this information?',
                        color: AppColors.redColor,
                        fontSize: Dimension.height15,
                      ),
                    );

                    await FirebaseFirestore.instance
                        .collection(widget.collectionName)
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then((DocumentSnapshot snapshot) {
                      if (snapshot.exists) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return dialogBox;
                            });
                      } else {
                        Utils.displaySnackbar('no document found', context);
                      }
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.redColor,
                  ))
            ],
          );
        }),
      ),
    );
  }
}
