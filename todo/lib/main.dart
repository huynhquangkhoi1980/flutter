import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/src/app.dart';
import 'package:todo/src/blocs/auth_bloc.dart';
import 'package:todo/src/resource/login_page.dart';
import 'package:oktoast/oktoast.dart';

// void main() => runApp(const MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
                AuthBloc(), 
                const OKToast(
                  child: MaterialApp(
                    home: LoginPage(),
                  ),
                )
              )
          );
}
