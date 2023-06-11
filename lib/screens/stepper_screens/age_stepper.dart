import 'package:flutter/material.dart';
import 'package:lone_soul/app_colors.dart';
import 'package:lone_soul/app_styles.dart';
import 'package:lone_soul/models/user.dart';
import 'package:lone_soul/utils/text_field_controller.dart';

class AgeStepper extends StatefulWidget {
  const AgeStepper({super.key, this.changeStepper, this.user});
  final Function? changeStepper;
  final AppUser? user;

  @override
  State<AgeStepper> createState() => _AgeStepperState();
}

class _AgeStepperState extends State<AgeStepper> {
  final ageKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    ageCreateAccountField = TextEditingController();
    ageCreateAccountFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "My Age is",
            style: AppStyles.boldHeader,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            width: 80,
            child: TextFormField(
              key: ageKey,
              onChanged: (value) {
                widget.user?.age = int.parse(value);
                setState(() {});
              },
              keyboardType: TextInputType.number,
              controller: ageCreateAccountField,
              focusNode: ageCreateAccountFocus,
              autofocus: true,
              validator: (input) {
                if (input!.isEmpty) {
                  return "Please enter your age";
                }

                if (int.tryParse(input)! < 18) {
                  return "You must be at least 18 years old";
                }
              },
              cursorColor: AppColors.brown,
              decoration: const InputDecoration(hintText: '23'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Your age is public",
            style: AppStyles.text.copyWith(color: AppColors.grey, fontSize: 14),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Center(
            child: InkWell(
          onTap: () {
            if (ageKey.currentState!.validate()) {
              //next screen gender
              widget.changeStepper!();
            }
          },
          child: Container(
            height: 55,
            width: 250,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                "Continue",
                style: AppStyles.text.copyWith(color: Colors.white),
              ),
            ),
          ),
        ))
      ],
    );
  }
}
