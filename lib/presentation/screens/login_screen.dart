import 'package:chat_app/core/constant.dart';
import 'package:chat_app/core/helper/show_snack_bar.dart';
import 'package:chat_app/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat_app/presentation/screens/chat_screen.dart';
import 'package:chat_app/presentation/screens/register_screen.dart';
import 'package:chat_app/presentation/widgets/custom_button.dart';
import 'package:chat_app/presentation/widgets/custom_row.dart';
import 'package:chat_app/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'loginScreen';
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  String? email;

  String? password;

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var loginProvider = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatScreen.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
          isLoading = false;
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, State) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: ListView(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Image.asset(
                  'assets/images/chatchirp-high-resolution-logo-transparent.png',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(
                  height: 180,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  icon: const Icon(Icons.email),
                ),
                CustomTextFormField(
                  onChange: (data) {
                    password = data;
                  },
                  isPassword: true,
                  labelName: 'Password',
                  hintName: 'Enter your Password',
                  icon: const Icon(Icons.password),
                ),
                CustomButton(
                    text: 'Sign In',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (email != null && password != null) {
                          loginProvider.add(
                              LoginEvent(email: email!, password: password!));
                        } else {
                          showSnackBar(
                              context, 'Please fill in all the fields');
                        }
                      }
                    }),
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
      ),
    );
  }
}
