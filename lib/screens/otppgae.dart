import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:web_dashboard_app_tut/screens/navigation_screen.dart';

import 'adminlogin.dart';

// import 'homepage.dart';
class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code="";
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar:true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,color: Colors.black,
          ),
        ),
      ),
      body:Container(
        margin: EdgeInsets.only(left: 25,right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: NetworkImage(
                    'data:image/jpeg;base64,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'), // Replace with your admin logo image asset
                height: 100,
                width: 100,
              ),
              Text('Phone Verification',style: TextStyle(
                  fontSize: 22,fontWeight: FontWeight.bold
              ),),
              SizedBox(
                height: 10,
              ),
              Text('We need to register your phone before getting started',style: TextStyle(
                fontSize: 16,
              ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),

              Pinput(
                length:6,
                showCursor: true,
                onChanged:(value){
                  code=value;
                }
                ,
              ),



              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width:300,
                child: ElevatedButton(onPressed : () async{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>NavigationScreen()),
                  );
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code);

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);

                },
                  child: Text('Verify Phone Number'),style: ElevatedButton.styleFrom(
                      primary: Color(0xff0660C6),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),) ,
              )

            ],
          ),
        ),
      ),
    );
  }
}
