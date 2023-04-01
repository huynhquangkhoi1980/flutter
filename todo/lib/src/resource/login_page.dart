import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:todo/src/app.dart';
import 'package:todo/src/blocs/login_bloc.dart';
import 'package:todo/src/resource/dialog/loading_dialog.dart';
import 'package:todo/src/resource/dialog/msg_dialog.dart';
import 'package:todo/src/resource/home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = LoginBloc();

  final TextEditingController _emailController = TextEditingController(text: 'tran.tu@gmail.com');
  final TextEditingController _passController = TextEditingController(text: 'ongrung0369');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Login Image
              const SizedBox(
                height: 50,
              ),
              Image.asset('assets/images/login_5.png'),
              // Login Title
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 6),
                child: Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              // Login sub title
              const Text(
                "Login to continue using Todolist",
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
              // Email input textbox
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                  child: StreamBuilder(
                    stream: bloc.userStream,
                    builder: (context, snapshot) => TextField(
                      controller: _emailController,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Email",
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Image.asset("assets/images/email_icon.png",
                                width: 20, height: 20),
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)))),
                    ),
                  )),

              // Password input textbox
              StreamBuilder(
                stream: bloc.passStream,
                builder: (context, snapshot) => TextField(
                  controller: _passController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      prefixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Image.asset(
                            "assets/images/password_icon.png",
                            width: 20,
                            height: 20,
                          )),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),

              // Forgot password link
              Container(
                constraints:
                    BoxConstraints.loose(const Size(double.infinity, 60)),
                alignment: AlignmentDirectional.centerEnd,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                  ),
                ),
              ),

              // Log in button
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 62,
                  child: TextButton(
                    onPressed: onSignInClicked,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange)),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

              // Sign Up link
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: RichText(
                  text: TextSpan(
                      text: "New user? ",
                      style: const TextStyle(
                          color: Color(0xff606470), fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()));
                              },
                            text: "Sign up for a new account",
                            style: const TextStyle(
                                color: Color(0xff3277D8), fontSize: 16))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSignInClicked() {
    String email = _emailController.text;
    String pass = _passController.text;

    var authBloc = MyApp.of(context)!.authBloc;
    LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc.signIn(email, 
                    pass,
                    () {
                        LoadingDialog.hideLoagingDialog(context);
                        Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => const HomePage()));
                    }, 
                    (msg) {
                            LoadingDialog.hideLoagingDialog(context);
                            MsgDialog.showMsgDialog(context, "Sign-In", msg);
                    }
                  );
  }
}
