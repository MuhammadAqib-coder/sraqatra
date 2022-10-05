import 'package:flutter/material.dart';

import '../../services/dimension.dart';
import '../../services/dropdown_provider.dart';
import '../../widgets/custom_textfield.dart';
import '../app_colors.dart';

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
          decoration: const BoxDecoration(color: AppColors.redColor),
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
                      onPressed: () {},
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
                      primary: AppColors.redColor,
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