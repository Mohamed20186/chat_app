import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_row.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static String id = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  String? email;

  String? password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: ListView(
            children: [
              SizedBox(
                height: 120,
              ),
              Image.asset(
                'assets/images/chatchirp-high-resolution-logo-transparent.png',
                height: 80,
                width: 80,
              ),
              SizedBox(
                height: 180,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.aldrich(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kSecondlyColor,
                    ),
                  ),
                ),
              ),
              CustomTextFormField(
                onChange: (data) {
                  email = data;
                },
                isPassword: false,
                labelName: 'Email',
                hintName: 'Enter your Email',
                icon: Icon(Icons.email),
              ),
              CustomTextFormField(
                onChange: (data) {
                  password = data;
                },
                isPassword: true,
                labelName: 'Password',
                hintName: 'Enter your Password',
                icon: Icon(Icons.password),
              ),
              CustomButton(
                text: 'Sign In',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await loginUser();
                      showSnackBar(
                        context,
                        'email login succesfully',
                      );
                      Navigator.pushNamed(context, ChatScreen.id,
                          arguments: email!);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(
                          context,
                          'user not found',
                        );
                      } else if (e.code == 'ERROR_WRONG_PASSWORD') {
                        showSnackBar(
                          context,
                          'wrong password',
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
                  }
                },
              ),
              CustomRow(
                callback: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                firstText: 'Don\'t have any account? ',
                secondText: 'Sign Up',
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!.trim(), password: password!);
  }
}
