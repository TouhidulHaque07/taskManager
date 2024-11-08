import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/login_model.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/service/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';

import 'package:taskmanager/ui/screens/forgot_email_password_screen.dart';
import 'package:taskmanager/ui/screens/main_button_nav_bar_screen.dart';
import 'package:taskmanager/ui/screens/sign_up_screen.dart';
import 'package:taskmanager/ui/utilits/app_colors.dart';
import 'package:taskmanager/ui/widgets/Screen_background.dart';
import 'package:taskmanager/ui/widgets/snacbar_massage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final TextEditingController _emailTEcontroller=TextEditingController();
  final TextEditingController _passwordTEcontroller=TextEditingController();
  bool isProgress=false;

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
            const SizedBox(
              height: 82,
            ),
            Text('Get Start With',
              style: textThem.displaySmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 24,
            ),
            _buildSignInForm(),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(onPressed: _onTapForgotPassowdButton,
                      child: const Text('Forgot Password?',style: TextStyle(
                        color: Colors.grey,
                      ),)),
                  buildSignUpSection(),
                ],
              ),
            )
          ],
        ),
      ),
    )));
  }

  Widget _buildSignInForm() {
    return Form(
      key: _formKey ,
      child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailTEcontroller,
                    keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                    hintText: 'Email',),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter Valid Email Address';
                      }
                      return null;
                    },
                  ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                   controller: _passwordTEcontroller,
                   decoration: InputDecoration(
                   hintText: 'Password',),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your Password';
                      }
                      if (value!.length < 6) {
                        return 'Enter a password more than 6 character';
                      }
                      return null;
                     }
                    ),
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: !isProgress,

                  child: ElevatedButton(
                      onPressed: _onTapNextbutton,
                      child: Icon(Icons.arrow_circle_right_outlined)),
                ),
              ],
            ),
    );
  }

  Widget buildSignUpSection() {
    return RichText(text: TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      text: "Don't have an account? ",
      children: [
        TextSpan(
          text: "Sign UP", style: TextStyle(
          color: AppColors.themColor,),
          recognizer:TapGestureRecognizer()..onTap=_onTapSignUp,
        )
      ],

    ));
  }

  void _onTapNextbutton(){
   if(!_formKey.currentState!.validate()){
     return;
    }
     _SignIn();
  }

  Future<void> _SignIn() async{
    isProgress=true;
    setState(() {});

    Map<String, dynamic> requestBody={
      'email': _emailTEcontroller.text.trim(),
      'password': _passwordTEcontroller.text,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Url: urls.login, body: requestBody);
    isProgress=false;
    setState(() {});
    if(response.isSuccess){
    LoginModel loginModel=LoginModel.fromJson(response.responseData);
    await AuthController.saveAccessToken(loginModel.token!);
    await AuthController.saveUserData(loginModel.data!);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainButtonNavBarScreen(),
          ),
              (value) => false);

    }
    else{
      showSnacBarMassage(context, response.erroMessage, true);
    }
  }

  void _onTapForgotPassowdButton(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotEmailPasswordScreen(),
      ),
    );
  }

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

}
