import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/user_model.dart';
import 'package:taskmanager/data/service/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/widgets/snacbar_massage.dart';
import 'package:taskmanager/ui/widgets/tm_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _fnameTEController=TextEditingController();
  final TextEditingController _lnameTEController=TextEditingController();
  final TextEditingController _phoneTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  XFile? _selectedImage;

  bool _updateInProgress=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setUserData();
  }
  void _setUserData(){
    _emailTEController.text=AuthController.userData?.email?? '';
    _fnameTEController.text=AuthController.userData?.firstName?? '';
    _lnameTEController.text=AuthController.userData?.lastName?? '';
    _phoneTEController.text=AuthController.userData?.mobile?? '';


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        isProfileScreenOpen:true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48,),
              Text('Update Profile',style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),),

                const SizedBox(height: 48,),
                _buildPhotoPicker(),
                const SizedBox(height: 8,),
               TextFormField(
                 enabled: false,
                 controller: _emailTEController,
                 decoration: const InputDecoration(
                   hintText: 'Email'

                 ),
                 validator: (String? value){
                    if(value?.trim()!.isEmpty?? true){
                      return 'Enter your email';
                    }
                    return null;
                 },
               ),
                const SizedBox(height: 8,),

                TextFormField(
                  controller: _fnameTEController,
                  decoration: const InputDecoration(
                      hintText: 'First Name'
                  ),
                  validator: (String? value){
                    if(value?.trim()!.isEmpty?? true){
                      return 'Enter your First Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),

                TextFormField(
                  controller: _lnameTEController,
                  decoration: const InputDecoration(
                      hintText: 'Last Name'
                  ),
                  validator: (String? value){
                    if(value?.trim()!.isEmpty?? true){
                      return 'Enter your Last Name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 8,),
                TextFormField(
                  controller: _phoneTEController,
                  decoration: const InputDecoration(
                      hintText: 'Phone'
                  ),
                  validator: (String? value){
                    if(value?.trim()!.isEmpty?? true){
                      return 'Enter your Phone Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),

                TextFormField(
                  controller: _passwordTEController,
                  decoration: const InputDecoration(
                      hintText: 'Password'
                  ),
                ),
            const SizedBox(height: 16,),

            Visibility(
              visible: _updateInProgress==false,
              replacement: Text('Wait'),
              child: ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    _updateProfile();
                  }
                },
                child: Icon(Icons.arrow_circle_right_outlined),),
            ),



              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _updateInProgress =true;
    setState(() {});
    Map<String, dynamic> requestBody={

      "email": _emailTEController.text.trim(),
      "firstName": _fnameTEController.text.trim(),
      "lastName": _lnameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),

    };
    if(_passwordTEController.text.isNotEmpty){
      requestBody['password']=_passwordTEController.text;
    }
    if(_selectedImage!=null){

      List<int> imageBytes= await _selectedImage!.readAsBytes();
      String convertedImage=base64Encode(imageBytes);
      requestBody['photo']= convertedImage;
    }
    final NetworkResponse response = await NetworkCaller.postRequest(
        Url: urls.updateProfile, body: requestBody);
    _updateInProgress=false;
    setState(() { });

    if(response.isSuccess){
      UserModel userModel=UserModel.fromJson(requestBody);
     AuthController.saveUserData(userModel);
      showSnacBarMassage(context, 'Profile has been updated');
    }else{
      showSnacBarMassage(context, response.erroMessage);
    }


  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _PickedImage,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text('Photo', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),),
            ),
            const SizedBox(width: 8,),
            Text(_getSelectedPhotoTitle()),
          ],
        ),
      
      ),
    );
  }

  String _getSelectedPhotoTitle(){
    if(_selectedImage !=null){
      return _selectedImage!.name;
    }
    return 'Select Photo';
  }

  Future<void> _PickedImage() async {
    ImagePicker imagePicker=ImagePicker();
    XFile? pickedImage= await  imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage==null){
      _selectedImage=pickedImage;
      setState(() { });
    }
  }

}
