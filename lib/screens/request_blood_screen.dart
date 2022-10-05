import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/res/app_colors.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/location_service.dart';
import 'package:sra_qatra/widgets/custom_dropdown.dart';
import 'package:sra_qatra/widgets/custom_text.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

import '../utils/utils.dart';

class RequestBloodScreen extends StatefulWidget {
  final Map<String, dynamic>? map;
  DropdownProvider? provider;
  RequestBloodScreen({Key? key, this.map, this.provider}) : super(key: key);

  @override
  State<RequestBloodScreen> createState() => _RequestBloodScreenState();
}

class _RequestBloodScreenState extends State<RequestBloodScreen> {
  final _formKey = GlobalKey<FormState>();
  final locControler = TextEditingController();
  final amountControler = TextEditingController();
  final phoneControler = TextEditingController();
  final timeControler = TextEditingController();
  late bool exist;
  late Position position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('accepters')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      exist = snapshot.exists;
    });
    getPosition();
  }

  getPosition() async {
    try {
      position = await LocationService.determinePosition();
    } on LocationServiceDisabledException catch (e) {
      Utils.displaySnackbar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    locControler.text = widget.map == null ? '' : widget.map!['location'];
    amountControler.text =
        widget.map == null ? '' : widget.map!['blood_amount'];
    phoneControler.text = widget.map == null ? '' : widget.map!['phone'];
    timeControler.text = widget.map == null ? '' : widget.map!['duration'];
    return Consumer<DropdownProvider>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: CustomText(text: 'Request Blood'),
            centerTitle: true,
            backgroundColor: AppColors.redColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: Dimension.height30,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      icon: Icons.location_on,
                      labelText: 'location',
                      onPressed: () {},
                      type: TextInputType.streetAddress,
                      controller: locControler,
                    ),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    CustomTextField(
                      icon: Icons.bloodtype_outlined,
                      labelText: 'blood amount',
                      onPressed: () {},
                      type: TextInputType.text,
                      controller: amountControler,
                    ),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    CustomTextField(
                      icon: Icons.phone,
                      labelText: 'phone',
                      onPressed: () {},
                      type: TextInputType.phone,
                      length: 11,
                      controller: phoneControler,
                    ),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    BloodDropdown(
                      provider: model,
                    ),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    CustomTextField(
                      icon: Icons.attachment_outlined,
                      labelText: 'when do you need?',
                      onPressed: () {},
                      type: TextInputType.text,
                      controller: timeControler,
                    ),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (!exist || widget.map == null) {
                            if (model.bloodGroup == 'blood group') {
                              Utils.displaySnackbar(
                                  'select blood group', context);
                            } else {
                              setAndUpdate('set', model);
                            }
                          } else {
                            if (model.bloodGroup == 'blood group') {
                              Utils.displaySnackbar(
                                  "select blood group", context);
                            } else {
                              setAndUpdate('update', model);
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.redColor),
                      child: CustomText(text: 'Become Accepter'),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  

  setAndUpdate(message, model) async {
    if (message == 'set') {
      FirebaseFirestore.instance
          .collection('accepters')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'location': locControler.text.trim(),
        'blood_amount': amountControler.text.trim(),
        'phone': phoneControler.text.trim(),
        'blood_group': model.bloodGroup,
        'duration': timeControler.text.trim(),
        'latitude': position.latitude,
        'longitude': position.longitude
      });
    Utils.displaySnackbar('You are now an Accepter', context);

    } else {
      FirebaseFirestore.instance
          .collection('accepters')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'location': locControler.text.trim(),
        'blood_amount': amountControler.text.trim(),
        'phone': phoneControler.text.trim(),
        'blood_group': model.bloodGroup,
        'duration': timeControler.text.trim(),
        'latitude': position.latitude,
        'longitude': position.longitude
      });
    Utils.displaySnackbar('Data Updated Successfully', context);

    }
    locControler.text = '';
    amountControler.text = '';
    phoneControler.text = '';
    model.setBloodgroup('blood group');
    timeControler.text = '';
  }
}
