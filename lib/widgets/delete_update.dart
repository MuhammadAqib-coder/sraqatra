import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/screens/donation_screen.dart';
import 'package:sra_qatra/screens/request_blood_screen.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';

import 'package:sra_qatra/widgets/custom_text.dart';

import '../services/dimension.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return ChangeNotifierProvider(
      create: (context) => DropdownProvider(),
      child: Consumer<DropdownProvider>(
        builder: ((context, value, child) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(Dimension.height8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      if (widget.collectionName == 'donors') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DonationScreen(
                                      map: map,
                                      provider: value,
                                    )));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RequestBloodScreen()));
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: const Color.fromRGBO(244, 66, 54, 1),
                    )),
                SizedBox(
                  height: Dimension.height10,
                ),
                IconButton(
                    onPressed: () {
                      var dialogBox = AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection(widget.collectionName)
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .delete();
                              },
                              child: CustomText(
                                text: 'Yes',
                                color: const Color.fromRGBO(244, 66, 54, 1),
                                fontSize: Dimension.height16,
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: CustomText(
                                fontSize: Dimension.height16,
                                text: 'No',
                                color: const Color.fromRGBO(244, 66, 54, 1),
                              ))
                        ],
                        title: CustomText(
                          text: 'Confirmation',
                          color: const Color.fromRGBO(244, 66, 54, 1),
                          fontSize: Dimension.height18,
                        ),
                        content: CustomText(
                          text: 'Do you want to delete this information?',
                          color: const Color.fromRGBO(244, 66, 54, 1),
                          fontSize: Dimension.height15,
                        ),
                      );
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return dialogBox;
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: const Color.fromRGBO(244, 66, 54, 1),
                    ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
