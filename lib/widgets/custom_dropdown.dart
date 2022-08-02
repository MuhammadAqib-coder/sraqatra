import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sra_qatra/services/dropdown_provider.dart';

import '../services/dimension.dart';

class BloodDropdown extends StatefulWidget {
  const BloodDropdown({
    Key? key,
    required this.provider,
  }) : super(key: key);
  final DropdownProvider provider;

  @override
  State<BloodDropdown> createState() => _BloodDropdownState();
}

class _BloodDropdownState extends State<BloodDropdown> {
  var list = <String>[
    'blood group',
    "A+",
    'B+',
    'A-',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  Widget build(BuildContext context) {
    // var dropProvider = Provider.of<DropdownProvider>(context);
    return Container(
      margin: EdgeInsets.only(left: Dimension.width10, right: Dimension.width5),
      padding: EdgeInsets.symmetric(horizontal: Dimension.width10),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(244, 66, 54, 1),
          borderRadius: BorderRadius.circular(Dimension.height10)),
      child: DropdownButton(
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: Colors.white,
          ),
          dropdownColor: const Color.fromRGBO(244, 66, 54, 1),
          value: widget.provider.bloodGroup,
          style: const TextStyle(color: Colors.white),
          underline: const Divider(
            color: Colors.transparent,
          ),
          items: list
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (String? value) {
            widget.provider.setBloodgroup(value);
          }),
    );
  }
}

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({Key? key, required this.provider}) : super(key: key);
  final DropdownProvider provider;

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  var list = ['gender', 'male', 'female', 'other'];
  @override
  Widget build(BuildContext context) {
    //var dropProvider = Provider.of<DropdownProvider>(context);
    return Container(
            margin: EdgeInsets.only(
                left: Dimension.width5, right: Dimension.width10),
            padding: EdgeInsets.symmetric(horizontal: Dimension.width10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(244, 66, 54, 1),
                borderRadius: BorderRadius.circular(Dimension.height10)),
            child: DropdownButton(
              dropdownColor: const Color.fromRGBO(244, 66, 54, 1),
              isExpanded: true,
              style: const TextStyle(color: Colors.white),
              icon: const Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Colors.white,
              ),
              underline: const Divider(
                color: Colors.transparent,
              ),
              value: widget.provider.gender,
              items: list
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              onChanged: (String? value) {
                widget.provider.setGender(value);
              },
            ),
          );
  }
}
