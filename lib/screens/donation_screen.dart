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

import '../res/app_colors.dart';
import '../services/dimension.dart';
import '../utils/utils.dart';

class DonationScreen extends StatefulWidget {
  DonationScreen({
    Key? key,
    this.map,
    this.provider
  }) : super(key: key);
  Map<String, dynamic>? map;
  DropdownProvider? provider;

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _dateControler = TextEditingController();
  final _nameControler = TextEditingController();
  final _locControler = TextEditingController();
  final _phoneControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late bool exist;
  late Position position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('donors')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => exist = value.exists);
    getPosition();
    // widget.map = ModalRoute.of(context)!.settings.arguments as widget.map<String, dynamic>;
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
    //var thisProvider = Provider.of<DropdownProvider>(context, listen: false);
    _dateControler.text = widget.map == null ? '' : widget.map!['date'];
    _nameControler.text = widget.map == null ? '' : widget.map!['name'];
    _locControler.text = widget.map == null ? '' : widget.map!['location'];
    _phoneControler.text = widget.map == null ? '' : widget.map!['phone'];
    // final String bloodGroup = widget.DUprovider == null
    //     ? 'blood group'
    //     : widget.DUprovider!.bloodGroup;
    // final String gender =
    //     widget.DUprovider == null ? 'gender' : widget.DUprovider!.gender;

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   thisProvider.setBloodgroup(bloodGroup);
    //   thisProvider.setGender(gender);
    // });
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'JazakAllah ror'),
        centerTitle: true,
        backgroundColor: AppColors.redColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimension.height10),
          child: Form(
              key: _formKey,
              child: Consumer<DropdownProvider>(
                builder: ((context, value, child) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: Dimension.height50,
                        backgroundColor: AppColors.redColor,
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
                          Expanded(child: BloodDropdown(provider: value)),
                          Expanded(child: GenderDropdown(provider: value))
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
                            if (!exist || widget.map == null) {
                              if (value.bloodGroup == 'blood group' ||
                                  value.gender == 'gender') {
                                Utils.displaySnackbar(
                                    'please enter bloodGroup or gender ',
                                    context);
                              } else {
                                setAndUpdateDoc(
                                  'set',
                                  value,
                                );
                              }
                            } else {
                              if (value.bloodGroup == 'blood group' ||
                                  value.gender == 'gender') {
                                Utils.displaySnackbar(
                                    'please enter bloodGroup or gender ',
                                    context);
                              } else {
                                setAndUpdateDoc('update', value);
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.redColor,
                        ),
                        child: CustomText(
                          text: 'Ready To Donate',
                          fontSize: Dimension.height16,
                        ),
                      )
                    ],
                  );
                }),
              )),
        ),
      ),
    );
  }

  void setAndUpdateDoc(message, model) async {
    if (message == 'set') {
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
      Utils.displaySnackbar(' Data saved Successfully', context);
    } else {
      FirebaseFirestore.instance
          .collection('donors')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'name': _nameControler.text.trim(),
        'location': _locControler.text.trim(),
        'phone': _phoneControler.text.trim(),
        'blood_group': model.bloodGroup,
        'gender': model.gender,
        'date': _dateControler.text.trim(),
        'latitude': position.latitude,
        'longitude': position.longitude
      });
      Utils.displaySnackbar(' Data Updated Successfully', context);
    }
    _nameControler.text = '';
    _locControler.text = '';
    _phoneControler.text = '';
    _dateControler.text = '';
    model.setBloodgroup('blood group');
    model.setGender('gender');
  }
}
