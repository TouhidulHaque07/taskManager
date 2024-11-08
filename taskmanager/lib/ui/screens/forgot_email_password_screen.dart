import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/SplashScreen.dart';
import 'package:taskmanager/ui/screens/forgot_email_otp_screen.dart';
import 'package:taskmanager/ui/utilits/app_colors.dart';
import 'package:taskmanager/ui/widgets/Screen_background.dart';

class ForgotEmailPasswordScreen extends StatefulWidget {
  const ForgotEmailPasswordScreen({super.key});

  @override
  State<ForgotEmailPasswordScreen> createState() => _ForgotEmailPasswordScreenState();
}

class _ForgotEmailPasswordScreenState extends State<ForgotEmailPasswordScreen> {
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
            Text('Your Email Address',
              style: textThem.displaySmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8,),
            Text('A 6 digit varification code will be send in your email address.',
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
              TextFormField(
                keyboardType:TextInputType.emailAddress ,
                decoration: InputDecoration(
                hintText: 'Email',
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotEmailOtpScreen(),
      ),
    );
  }

  void _onTapSignIn(){

    Navigator.pop(context);

  }

}
