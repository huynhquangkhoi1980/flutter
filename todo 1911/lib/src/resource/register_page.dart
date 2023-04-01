import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo/src/blocs/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = AuthBloc();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    // Due to close stream
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff3277D8)),
        elevation: 0,
      ),
      // Body
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Page title
              const SizedBox(
                height: 5,
              ),
              Image.asset("assets/images/join_us.png"),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 6),
                child: Text(
                  "Manage your works!",
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              // Page sub title
              const Text(
                "Sign up with Todolist in simple steps",
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),

              // UserName input textbox
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: StreamBuilder(
                  stream: authBloc.nameStream,
                  builder: (context, snapshot) => TextField(
                    controller: _nameController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        errorText: snapshot.hasError? snapshot.error.toString() : null,
                        labelText: "Name",
                        prefixIcon: SizedBox(
                            width: 50,
                            child: Image.asset("assets/images/user_icon.png")),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6))))),
                  ),                    
              ),

              // Phone input textbox
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: StreamBuilder(
                  stream: authBloc.phoneStream,
                  builder: (context, snapshot) => TextField(
                    controller: _phoneController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      errorText: snapshot.hasError? snapshot.error.toString() : null,
                      labelText: "Phone number",
                      prefixIcon: SizedBox(
                          width: 50,
                          child: Image.asset("assets/images/phone_icon.png")),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                  ),
                )
              ),

              // Email input textbox
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) => TextField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        errorText: snapshot.hasError? snapshot.error.toString() : null,
                        labelText: "Email",
                        prefixIcon: SizedBox(
                            width: 50,
                            child: Image.asset("assets/images/email_icon.png")),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
                )
              ),

              // Password input textbox
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: StreamBuilder(
                  stream: authBloc.passStream,
                  builder: (context, snapshot) => TextField(
                    controller: _passController,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText: snapshot.hasError? snapshot.error.toString() : null,
                    labelText: "Password",
                    prefixIcon: SizedBox(
                        width: 50,
                        child:
                            Image.asset("assets/images/password_icon.png")),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
                  ),
                )
              ),
              // Sign up button
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: TextButton(
                      onPressed: onSignUpClicked,
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange))),
                ),
              ),
              // Login now link
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: RichText(
                  text: const TextSpan(
                      text: "Already a User? ",
                      style: TextStyle(color: Color(0xff606470), fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Login now",
                            style: TextStyle(
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

    void onSignUpClicked() {
    if (authBloc.isValid(_nameController.text, _emailController.text, _passController.text, _phoneController.text)) {}
  }
}
