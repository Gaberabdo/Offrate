import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sell_4_u/Features/Auth-feature/presentation/pages/register/register_screen.dart';

import '../../../../../generated/l10n.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({Key? key}) : super(key: key);

  var phoneController = TextEditingController();
  var globalFormKey = GlobalKey<FormState>();
  String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Create Account',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: globalFormKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              TextFormField(
                cursorColor: Colors.black,
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return S.of(context).pleasePhone;
                  }
                  return null;
                },
                keyboardAppearance: Brightness.dark,
                decoration: InputDecoration(
                  labelText: S.of(context).Phone,
                  labelStyle: GoogleFonts.tajawal(
                    fontSize: 20,
                  ),
                  prefixIcon: const Icon(
                    Icons.phone,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    // Set the border radius
                    borderSide: BorderSide.none, // R;emove the border
                  ),
                  filled: true,
                ),
              ),
              SizedBox(height: 50),
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (globalFormKey.currentState!.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterScreen(
                            phoneNumber: phoneController.text);
                      }));
                    }
                  },
                  child: Text(
                    S.of(context).completeSignUp,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
