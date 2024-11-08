import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/service/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/SplashScreen.dart';
import 'package:taskmanager/ui/utilits/app_colors.dart';
import 'package:taskmanager/ui/widgets/Screen_background.dart';
import 'package:taskmanager/ui/widgets/snacbar_massage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final GlobalKey<FormState> _fromKey=GlobalKey<FormState>();

final TextEditingController _emailTEController=TextEditingController();
final TextEditingController _firstNameTEController=TextEditingController();
final TextEditingController _lastNameTEController=TextEditingController();
final TextEditingController _mobileNoTEController=TextEditingController();
final TextEditingController _passwordTEController=TextEditingController();

bool _isProgress=false;

class _SignUpScreenState extends State<SignUpScreen> {
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
            Text(
              'Join With Us',
              style:
                  textThem.displaySmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 24,
            ),
            _buildSignUpForm(),
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


   Widget _buildSignUpForm() {
    return Form(
        key: _fromKey,
      child: Column(
              children: [
                TextFormField(
                  controller: _emailTEController,
                  keyboardType:TextInputType.emailAddress ,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                  hintText: 'Email',

                ),
                  validator:(String? value){
                    if(value?.isEmpty??true){
                      return "Enter Valid email";
                    }
                    return null;
                  } ,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _firstNameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                  hintText: 'First Name',
                ),
                  validator:(String? value){
                    if(value?.isEmpty??true){
                      return "Enter Valid First Name";
                    }
                    return null;
                  } ,

                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    controller: _lastNameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                    hintText: 'Last Name',
                    ),
                  validator:(String? value){
                    if(value?.isEmpty??true){
                      return "Enter Valid Last Name";
                    }
                    return null;
                  } ,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                      controller: _mobileNoTEController,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                  validator:(String? value){
                    if(value?.isEmpty??true){
                      return "Enter Valid Mobile No";
                    }
                    return null;
                  } ,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  validator:(String? value){
                    if(value?.isEmpty??true){
                      return "Enter Valid Mobile No";
                    }

                  } ,

                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: _onTapNextbutton,
                    child: Icon(Icons.arrow_circle_right_outlined)),
              ],
            ),
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

    if(_fromKey.currentState!.validate()){
      _signUp();
    }
   }

  Future<void>_signUp () async{
    _isProgress=true;
    setState(() {});

    Map<String, dynamic> requestBody={
      "email":_emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_mobileNoTEController.text.trim(),
      "password":_passwordTEController.text,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
       Url: urls.registration,
        body:requestBody
    );

    _isProgress=false;
    setState(() {});

    if(response.isSuccess){
      _clearTextForm();
      showSnacBarMassage(context,'New User Created');
      }
    else{
      showSnacBarMassage(context,response.erroMessage,true);

    }
  }

  void _clearTextForm(){
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileNoTEController.clear();
    _passwordTEController.clear();
  }


  void _onTapSignIn(){

    Navigator.pop(context);

  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileNoTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }

}
