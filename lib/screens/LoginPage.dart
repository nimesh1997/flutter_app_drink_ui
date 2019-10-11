import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_drink_ui/screens/HomePage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String countryCode = '+91';
String phoneNumber = '';
FirebaseAuth firebaseAuth;
FirebaseUser firebaseUser;

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController;
  TextEditingController smsOtpController;

  String verificationId = '';
  String smsOtp = '';
  FocusNode phoneNumberNode;

  @override
  void initState() {
    super.initState();
    phoneNumberNode = FocusNode();
    getLoginStatus().then((status){
      if(status){
        Fluttertoast.showToast(msg: 'AlreadyLoggedIn');
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Material(child: HomePage())));
        });
//        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }else{
        Fluttertoast.showToast(msg: 'Not AlreadyLoggedIn');
//        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Material(child: LoginPage())));
      }
    }).catchError((onError){
      print('catchError: getLoginStatus: ' + onError.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);


    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Stack(
//        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
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
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: TextField(
                  focusNode: phoneNumberNode,
                  autofocus: false,
                  decoration: InputDecoration(labelText: 'Enter your phone number', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: phoneNumberController,
                  onChanged: (value) {
                    setState(() {
                      print('onChanged: ' + value);
                      phoneNumber = value;
                    });
                  },
                  onSubmitted: (value) {
                    print('phoneController: ' + value);
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),
              ),
              RaisedButton(
                color: Colors.white,
                shape: StadiumBorder(),
                onPressed: () {
                  if (phoneNumber.trim().isEmpty || phoneNumber.trim().length < 10) {
                    print('Please Enter 10 digit phone number');
                    Fluttertoast.showToast(msg: 'Please Enter 10 digit phone number');
                  } else {
                    print('verify phone number called...');

                    /// calling firebase functions for authentication
                    /// sends the code to the specified phone number
                    sendCodeToPhoneNumber();
                  }
                },
                child: Text('Login'),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential authCredential) async {
      print('phoneVerificationCompleted called.\n');
      print('authCredential: ' + authCredential.toString());
      print('phoneVerification auto succeeded:');
      await FirebaseAuth.instance.signInWithCredential(authCredential).then((AuthResult user) {
        setState(() {
          firebaseUser = user.user;
          print('phoneVerification auto succeeded with user:' + user.user.toString());
        });
        checkUserAlreadyExist('+91' + phoneNumber);
      }).catchError((onError) {
        setState(() {
          print('catchError phoneVerficationCompleted: ' + onError.toString());
        });
      });
    };

    final PhoneVerificationFailed phoneVerificationFailed = (AuthException authException) {
      setState(() {
        print('phoneVerificationFailed called...');
        print('phoneVerificationFailed code: ' + authException.code.toString());
      });
    };

    final PhoneCodeSent phoneCodeSent = (String verificationId, [int forceResendingToken]) async {
      setState(() {
        print('phoneCodeSent Called...');
        print('verificationId: ' + verificationId + ' forceResendingToken: ' + forceResendingToken.toString());
        verificationId = verificationId;
      });
    };checkUserAlreadyExist('+91' + phoneNumber);

    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout = (String verificationId) {
      setState(() {
        print('phoneCodeAutoRetrievalTimeout Called');
        print('verficationId: ' + verificationId);
        print('timeOut');
      });
    };

    await FirebaseAuth.instance
        .verifyPhoneNumber(
            phoneNumber: countryCode + phoneNumber,
            timeout: Duration(seconds: 30),
            verificationCompleted: verificationCompleted,
            verificationFailed: phoneVerificationFailed,
            codeSent: phoneCodeSent,
            codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout)
        .catchError((onError) {
      print('catchError verifyPhoneNumber: ' + onError.toString());
    });
  }

  Future<void> checkUserAlreadyExist(String phoneNumber) async{
    print('checkUserAlreadyExist called');
//    FirebaseDatabase firebaseDatabase = FirebaseDatabase(databaseURL: 'https://flutterdrinkui.firebaseio.com');
    FirebaseDatabase.instance.reference().child('users').child(phoneNumber).child('authNumber').once().then((DataSnapshot snapShot){
      if(snapShot.value != null){
        print('snapShot exist');
      }else{
        print('snapShot not exist');
        FirebaseDatabase.instance.reference().child('users').child(phoneNumber).set({'authNumber' : phoneNumber});
      }
    }).catchError((onError){
      print('catchError checkUserAlreadyExisted: ' + onError.toString());
    });
  }

  Future<bool> getLoginStatus() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseUser = await firebaseAuth.currentUser();
    print('getLoginStatus firebaseUser details: ' + firebaseUser.toString());
    if(firebaseUser != null && firebaseUser.phoneNumber != null){
      return true;
    }else{
      return false;
    }

  }
}
