import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/Reset_password_screen.dart';
import 'package:taskmanager/ui/screens/SplashScreen.dart';
import 'package:taskmanager/ui/screens/sign_in_screen.dart';
import 'package:taskmanager/ui/utilits/app_colors.dart';
import 'package:taskmanager/ui/widgets/Screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class ForgotEmailOtpScreen extends StatefulWidget {
  const ForgotEmailOtpScreen({super.key});

  @override
  State<ForgotEmailOtpScreen> createState() => _ForgotEmailOtpScreenState();
}

class _ForgotEmailOtpScreenState extends State<ForgotEmailOtpScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textThem = Theme.of(context).textTheme;

    return Scaffold(
        body: Screenbackground(
            child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 82,),
            Text('Pin Verification',
              style: textThem.displaySmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8,),
            Text('A 6 digit varification code has beed send in your email address.',
              style: textThem.titleSmall?.copyWith(color: Colors.grey),

            ),
            const SizedBox(height: 24,),
            _buildVarifyEmailForm(),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  _buildHaveAccountSection(),
                ],
              ),
            )
          ],
        ),
      ),
    )));
  }


   Widget _buildVarifyEmailForm() {
    return Column(
            children: [
              PinCodeTextField(
                length: 6,
                obscureText: false,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,

                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                }, appContext: context,
              ),

           const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: _onTapNextbutton,
                  child: Icon(Icons.arrow_circle_right_outlined)),
            ],
          );
  }

  Widget _buildHaveAccountSection() {
    return RichText(text: TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      text: "Have account? ",
      children: [
        TextSpan(
          text: "Sign In", style: TextStyle(
          color: AppColors.themColor,),
          recognizer:TapGestureRecognizer()..onTap=_onTapSignIn,
        )
      ],

    ));
  }

  void _onTapNextbutton(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordScreen(),
      ),
    );
  }

  void _onTapSignIn(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ),
        (_) => false);
  }

}
