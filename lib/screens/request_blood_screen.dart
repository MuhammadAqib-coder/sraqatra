import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/services/location_service.dart';
import 'package:sra_qatra/widgets/custom_dropdown.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

class RequestBloodScreen extends StatefulWidget {
  const RequestBloodScreen({Key? key}) : super(key: key);

  @override
  State<RequestBloodScreen> createState() => _RequestBloodScreenState();
}

class _RequestBloodScreenState extends State<RequestBloodScreen> {
  final _formKey = GlobalKey<FormState>();
  final locControler = TextEditingController();
  final baControler = TextEditingController();
  final phoneControler = TextEditingController();
  final timeControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return DropdownProvider();
      },
      child: Consumer<DropdownProvider>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Request Blood'),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
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
                        controller: baControler,
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
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            if (model.bloodGroup == 'blood group') {
                              _displaySnackbar('select blood group');
                            } else {
                              try {
                                Position position = await LocationService.determinePosition();
                                FirebaseFirestore.instance
                                  .collection('accepters')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                    'location': locControler.text.trim(),
                                    'blood_amount' : baControler.text.trim(),
                                    'phone': phoneControler.text.trim(),
                                    'blood_group': model.bloodGroup,
                                    'duration': timeControler.text.trim(),
                                    'latitude':position.latitude,
                                    'longitude': position.longitude
                                  });
                              } on LocationServiceDisabledException catch (e) {
                                _displaySnackbar(e.toString());
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(244, 66, 54, 1)),
                        child: const Text('become accepter'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _displaySnackbar(messege) {
    var snackBar = SnackBar(content: Text(messege));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
