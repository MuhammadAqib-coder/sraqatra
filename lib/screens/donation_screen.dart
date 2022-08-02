import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/widgets/custom_dropdown.dart';
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
  final _fromKey = GlobalKey<FormState>();
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
              title: const Text("JazakAllah ror"),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Dimension.height10),
                child: Form(
                  key: _fromKey,
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
                      ),
                      SizedBox(
                        height: Dimension.height8,
                      ),
                      CustomTextField(
                        type: TextInputType.streetAddress,
                        controller: _locControler,
                        icon: Icons.location_on,
                        labelText: "Location",
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
                        onPressed: () {
                          if (_fromKey.currentState!.validate()) {
                            if (model.bloodGroup == 'blood group' ||
                                model.gender == 'gender') {
                              _displaySnackbar(
                                  'please enter bloodGroup or gender ');
                            } else {
                              FirebaseFirestore.instance
                                  .collection('donors')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                    
                                  });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(244, 66, 54, 1),
                        ),
                        child: const Text('ready to donate'),
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
    var snackBar = SnackBar(content: Text(value));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
