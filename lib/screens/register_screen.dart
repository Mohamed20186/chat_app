import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_row.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String id = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: kSecondlyColor,
      child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 120,
                ),
                Image.asset(
                  'assets/images/chatchirp-high-resolution-logo-transparent.png',
                  width: 80,
                  height: 80,
                ),
                SizedBox(
                  height: 180,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Register',
                      style: GoogleFonts.aldrich(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kSecondlyColor,
                      ),
                    ),
                  ),
                ),
                CustomTextFormField(
                  isPassword: false,
                  labelName: 'Email',
                  hintName: 'Enter your Email',
                  icon: const Icon(Icons.email),
                  onChange: (data) {
                    email = data;
                  },
                ),
                CustomTextFormField(
                  isPassword: true,
                  labelName: 'Password',
                  hintName: 'Enter your Password',
                  icon: const Icon(Icons.password),
                  onChange: (pass) {
                    password = pass;
                  },
                ),
                CustomButton(
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        showSnackBar(
                          context,
                          'email created succesfully...',
                        );
                        Navigator.pushNamed(context, ChatScreen.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                            context,
                            'weak password',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                            context,
                            'email already in use',
                          );
                        }
                      } catch (e) {
                        showSnackBar(
                          context,
                          e.toString(),
                        );
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                ),
                CustomRow(
                  firstText: 'already have an account? ',
                  secondText: 'Login',
                  callback: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email!.trim(), password: password!);
  }
}
