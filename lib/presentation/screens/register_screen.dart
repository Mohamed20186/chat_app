import 'package:chat_app/core/constant.dart';
import 'package:chat_app/core/helper/show_snack_bar.dart';
import 'package:chat_app/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:chat_app/presentation/screens/chat_screen.dart';
import 'package:chat_app/presentation/widgets/custom_button.dart';
import 'package:chat_app/presentation/widgets/custom_row.dart';
import 'package:chat_app/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  String? email;

  String? password;

  bool isLoading = false;
  static String id = 'registerScreen';
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var sginUp = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SginupLoading) {
          isLoading = true;
        } else if (state is SginupSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, ChatScreen.id, arguments: email);
        } else if (state is SginupFailure) {
          isLoading = false;
          showSnackBar(context, "there was an error");
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          color: kSecondlyColor,
          child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Image.asset(
                      'assets/images/chatchirp-high-resolution-logo-transparent.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 180,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          sginUp.registerUser(
                              email: email!, password: password!);
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
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
