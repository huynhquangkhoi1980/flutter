import 'package:flutter/material.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        // not close dialog when click out of dialog range
        barrierDismissible: false,
        builder: (context) => Dialog(
              child: Container(
                color: Colors.white,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        msg,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  static void hideLoagingDialog(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog());
  }
}
