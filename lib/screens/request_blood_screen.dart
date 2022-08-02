import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/services/dimension.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';
import 'package:sra_qatra/widgets/custom_dropdown.dart';
import 'package:sra_qatra/widgets/custom_textfield.dart';

class RequestBloodScreen extends StatefulWidget {
  const RequestBloodScreen({Key? key}) : super(key: key);

  @override
  State<RequestBloodScreen> createState() => _RequestBloodScreenState();
}

class _RequestBloodScreenState extends State<RequestBloodScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return DropdownProvider();
      },
      child: Consumer<DropdownProvider>(
        builder: (context, model, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Request Blood'),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                top: Dimension.height30,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        icon: Icons.location_on, labelText: 'location'),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    CustomTextField(
                        icon: Icons.bloodtype_outlined,
                        labelText: 'blood amount'),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    CustomTextField(icon: Icons.phone, labelText: 'phone'),
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
                        labelText: 'when do you need?'),
                    SizedBox(
                      height: Dimension.height10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(244, 66, 54, 1)),
                      child: const Text('become accepter'),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
