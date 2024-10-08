import 'package:chat_app/core/firebase_options.dart';
import 'package:chat_app/core/simple_bloc_observer.dart';
import 'package:chat_app/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:chat_app/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat_app/presentation/screens/chat_screen.dart';
import 'package:chat_app/presentation/screens/login_screen.dart';
import 'package:chat_app/presentation/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    () {
      runApp(const RmChat());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class RmChat extends StatelessWidget {
  const RmChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          ChatScreen.id: (context) => ChatScreen(),
        },
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: LoginScreen.id,
      ),
    );
  }
}
