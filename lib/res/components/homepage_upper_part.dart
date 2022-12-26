import 'package:flutter/material.dart';

import '../../services/dimension.dart';
import '../../services/dropdown_provider.dart';
import '../../widgets/custom_textfield.dart';
import '../app_colors.dart';

class UpperPart extends StatefulWidget {
  UpperPart({Key? key, required this.searchControler, required this.model})
      : super(key: key);
  // var searchControler = TextEditingController();
  final TextEditingController searchControler;
  DropdownProvider model;

  @override
  State<UpperPart> createState() => _UpperPartState();
}

class _UpperPartState extends State<UpperPart> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
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
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              child: Column(
                children: [
                  TextField(
                    controller: widget.searchControler,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.bloodtype),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.redColor))),
                    onChanged: (value) {
                      setState(() {});
                    },
                  )

                  // Form(
                  //   key: _formKey,
                  //   child: CustomTextField(
                  //     icon: Icons.bloodtype,
                  //     labelText: "blood type",
                  //     controller: searchControler,
                  //     type: TextInputType.text,
                  //     onPressed: () {},
                  //   ),
                  // ),
                  ,
                  SizedBox(
                    height: Dimension.height30,
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       model.setSearch(
                  //           searchControler.text.toUpperCase().trim());
                  //       _formKey.currentState!.reset();
                  //     }
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary: AppColors.redColor,
                  //   ),
                  //   child: Text(
                  //     'search',
                  //     style: TextStyle(fontSize: Dimension.height16),
                  //   ),
                  // )
                ],
              )),
        ),
      ],
    );
  }
}
