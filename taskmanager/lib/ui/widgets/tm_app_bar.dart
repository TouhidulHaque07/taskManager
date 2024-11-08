
import 'package:flutter/material.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/screens/profile_screen.dart';
import 'package:taskmanager/ui/screens/sign_in_screen.dart';
import 'package:taskmanager/ui/utilits/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreenOpen=false,
  });
  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(isProfileScreenOpen){
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ),
        );
      },
      child: AppBar(
        backgroundColor: AppColors.themColor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 16,),
            Expanded(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(

                      AuthController.userData?.fulname ?? '' , style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),
                    ),
                    Text(AuthController.userData?.email ?? '' ,style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),
                    ),
                  ],
                )
            ),
            IconButton(onPressed: () async{
              await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                      (predicate) => false);
                }, icon: Icon(Icons.logout)),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
