import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/SplashScreen.dart';
import 'package:taskmanager/ui/screens/forgot_email_otp_screen.dart';
import 'package:taskmanager/ui/screens/sign_in_screen.dart';
import 'package:taskmanager/ui/screens/sign_up_screen.dart';
import 'package:taskmanager/ui/utilits/app_colors.dart';
import 'package:taskmanager/ui/widgets/Screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
            Text('Set Password',
              style: textThem.displaySmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8,),
            Text('Minimum number of password should be 8 letters',
              style: textThem.titleSmall?.copyWith(color: Colors.grey),

            ),
            const SizedBox(height: 24,),
            _buildResetPasswordForm(),
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


   Widget _buildResetPasswordForm() {
    return Column(
            children: [
              TextFormField(

                decoration: InputDecoration(
                hintText: 'Password',
              )),
              const SizedBox(
                height: 8,
              ),
              TextFormField(

                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                  )),

           const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: _onTapNextbutton,
                  child: Icon(Icons.arrow_circle_right_outlined)),
              const SizedBox(
                height: 48,
              ),
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
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ), (_) => false);
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
