import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_drink_ui/screens/CountDownWidget.dart';
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

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  TextEditingController phoneNumberController;
  TextEditingController smsOtpController;

  String verificationId = '';
  String smsOtp = '';
  bool otpSend = false;
  bool showResendButton = false;
  bool enableResendButton = false;

  int startValue = 30;

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    print('initState Called');
    animationController = AnimationController(vsync: this, duration: Duration(seconds: startValue));
    phoneNumberController = TextEditingController();
    smsOtpController = TextEditingController();
    getLoginStatus().then((status){
      if(status){
        Fluttertoast.showToast(msg: 'AlreadyLoggedIn');
        setState(() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Material(child: HomePage())));
        });
      }else{
        Fluttertoast.showToast(msg: 'Not AlreadyLoggedIn');
      }
    }).catchError((onError){
      print('catchError: getLoginStatus: ' + onError.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    if(enableResendButton){
      print('enableResendButton: ' + enableResendButton.toString());
      animationController.forward(from: 0.0);
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Stack(
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
                child: !otpSend ? TextField(
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
                ) : TextField(
                  autofocus: false,
                  decoration: InputDecoration(labelText: 'Enter Otp sent to your phone number', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  controller: smsOtpController,
                  onChanged: (value) {
                    setState(() {
                      print('onChanged sms: ' + value);
                      smsOtp = value;
                    });
                  },
                  onSubmitted: (value) {
                    print('smsOtpController: ' + value);
                    setState(() {
                      smsOtp = value;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  showResendButton ? InkWell(child: Text('Resend Otp'),
                    onTap: (){
                      print('Resend Otp...');
                      setState(() {
                        showResendButton = false;
                      });
                      /// again send the code to the particular phone number
                      sendCodeToPhoneNumber();
                    },) : enableResendButton ? CountDownWidget(animation: StepTween(begin: startValue, end: 0,).animate(animationController)..
                  addStatusListener((statusListener){
                    if(statusListener == AnimationStatus.completed){
                      setState(() {
                        showResendButton = true;
                        enableResendButton = false;
                      });
                    }
                  })) : SizedBox(),
                ],
              ),
              !otpSend ? RaisedButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: Colors.white,
                shape: StadiumBorder(),
                onPressed: () {
                  if (phoneNumber.trim().isEmpty || phoneNumber.trim().length < 10) {
                    print('Please Enter 10 digit phone number');
                    Fluttertoast.showToast(msg: 'Please Enter 10 digit phone number');
                  } else {

                    phoneNumberController.clear();
                    print('verify phone number called...');
                    setState(() {
                      otpSend = true;
                      enableResendButton = true;
//                      showResendButton = true;
                    });
                    /// calling firebase functions for authentication
                    /// sends the code to the specified phone number
                    sendCodeToPhoneNumber();
                  }
                },
                child: Text('Login'),
              ) :  RaisedButton(
                color: Colors.white,
                shape: StadiumBorder(),
                onPressed: () {
                  verifyOtp();
                },
                child: Text('Next'),
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

          firebaseUser = user.user;
          print('phoneVerification auto succeeded with user:' + user.user.toString());
          setState(() {});
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

    final PhoneCodeSent phoneCodeSent = (String verId, [int forceResendingToken]) async {
      setState(() {
        print('phoneCodeSent Called...');
        print('verificationId: ' + verificationId + ' forceResendingToken: ' + forceResendingToken.toString());
        verificationId = verId;

      });
    };

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
    FirebaseDatabase.instance.reference().child('users').child(phoneNumber).child('authNumber').once().then((DataSnapshot snapShot){
      if(snapShot.value != null){
        print('snapShot exist');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Material(child: HomePage())));
      }else{
        print('snapShot not exist');
        FirebaseDatabase.instance.reference().child('users').child(phoneNumber).set({'authNumber' : phoneNumber});
        checkUserAlreadyExist(phoneNumber);

      }
    }).catchError((onError){
      print('catchError checkUserAlreadyExisted: ' + onError.toString());
    });
  }

  Future<bool> getLoginStatus() async{
    print('getLoginStatus Called');
    firebaseAuth = FirebaseAuth.instance;
    firebaseUser = await firebaseAuth.currentUser();
    print('firebase details: ' + firebaseAuth.currentUser().toString());
    setState(() {});
    print('getLoginStatus firebaseUser details: ' + firebaseUser.toString());
    if(firebaseUser != null && firebaseUser.phoneNumber != null){
      return true;
    }else{
      return false;
    }

  }

  void verifyOtp() async{
    if (smsOtp.trim().isEmpty || smsOtp.trim().length < 6) {
      print('Please Enter 6 digit phone number');
      Fluttertoast.showToast(msg: 'Please Enter 6 digit phone number');
    } else {
      print('verify otp...');
      Fluttertoast.showToast(msg: 'Verifying Otp...');

      try{
        final AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsOtp);
        await firebaseAuth.signInWithCredential(credential).then((AuthResult user){
          firebaseUser = user.user;
          print('phoneVerification auto succeeded with user:' + user.user.toString());
          checkUserAlreadyExist('+91' + phoneNumber);

        }).catchError((PlatformException onError){
          print('verify Otp catchError: ' + onError.toString());
          print('verify Otp catchError Code: ' + onError.code.toString());
          if(onError.code.toString() == 'ERROR_INVALID_VERIFICATION_CODE'){
            Fluttertoast.showToast(msg: 'Please Enter Correct Otp');
          }
        });
      }catch (e){
        print('verifyOtp error: ' + e.toString());
      }

    }
  }
}
