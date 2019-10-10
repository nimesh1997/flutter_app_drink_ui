import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController;
  TextEditingController smsOtpController;
  int phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.grey)]),
            width: 80.0,
            height: 80.0,
            alignment: Alignment.center,
            child: FlutterLogo(
              duration: Duration(seconds: 3),
              size: 40.0,
              curve: Curves.bounceOut,
            ),
          ),
          Container(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: 'Enter your phone number'),
              keyboardType: TextInputType.number,
              maxLength: 10,
              controller: phoneNumberController,
              onSubmitted: (value) {
                print('phoneController: ' + value);
              },
            ),
          ),
          RaisedButton(
            onPressed: () {

            },
            child: Text('Login'),
          )
        ],
      ),
    );
  }
}
