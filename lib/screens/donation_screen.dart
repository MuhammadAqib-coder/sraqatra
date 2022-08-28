//the textformfiield is not clear on _formkey.currentState.reset();

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/location_service.dart';
import 'package:sra_qatra/widgets/custom_dropdown.dart';
import 'package:sra_qatra/widgets/custom_text.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

import '../services/dimension.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _dateControler = TextEditingController();
  final _nameControler = TextEditingController();
  final _locControler = TextEditingController();
  final _phoneControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DropdownProvider>(
      create: (_) {
        return DropdownProvider();
      },
      child: Consumer<DropdownProvider>(
        builder: ((context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: CustomText(text: 'JazakAllah ror'),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Dimension.height10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: Dimension.height50,
                        backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
                      ),
                      SizedBox(
                        height: Dimension.height5,
                      ),
                      CustomTextField(
                        type: TextInputType.name,
                        controller: _nameControler,
                        icon: Icons.account_circle,
                        labelText: "Name",
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: Dimension.height8,
                      ),
                      CustomTextField(
                        type: TextInputType.streetAddress,
                        controller: _locControler,
                        icon: Icons.location_on,
                        labelText: "Location",
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: Dimension.height8,
                      ),
                      CustomTextField(
                        type: TextInputType.phone,
                        controller: _phoneControler,
                        icon: Icons.phone,
                        labelText: "Phone",
                        length: 11,
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: Dimension.height8,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: BloodDropdown(
                            provider: model,
                          )),
                          Expanded(
                              child: GenderDropdown(
                            provider: model,
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        type: TextInputType.datetime,
                        icon: Icons.calendar_month_outlined,
                        labelText: 'date',
                        controller: _dateControler,
                        onPressed: () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5));
                          _dateControler.text = date == null
                              ? ''
                              : '${date.day}/${date.month}/${date.year}';
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (model.bloodGroup == 'blood group' ||
                                model.gender == 'gender') {
                              _displaySnackbar(
                                  'please enter bloodGroup or gender ');
                            } else {
                              try {
                                Position position =
                                    await LocationService.determinePosition();
                                FirebaseFirestore.instance
                                    .collection('donors')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .set({
                                  'name': _nameControler.text.trim(),
                                  'location': _locControler.text.trim(),
                                  'phone': _phoneControler.text.trim(),
                                  'blood_group': model.bloodGroup,
                                  'gender': model.gender,
                                  'date': _dateControler.text.trim(),
                                  'latitude': position.latitude,
                                  'longitude': position.longitude
                                });
                                //_formKey.currentState!.reset();
                                _nameControler.text = '';
                                _locControler.text = '';
                                _phoneControler.text = '';
                                _dateControler.text = '';
                                model.setBloodgroup('blood group');
                                model.setGender('gender');
                                _displaySnackbar('Donor data saved Successfully');
                              } on LocationServiceDisabledException catch (e) {
                                _displaySnackbar(e.toString());
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(244, 66, 54, 1),
                        ),
                        child: CustomText(text: 'Ready To Donate',fontSize: Dimension.height16,),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _displaySnackbar(value) {
    var snackBar = SnackBar(content: Text(value),backgroundColor: const Color.fromRGBO(244, 66, 54, 1),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
