import 'package:flutter/material.dart';
import 'package:mbap_project_app/models/user.dart';

//Creating profile picture widget

class ProfilePicWidget extends StatelessWidget{

  final FirestoreUser user; //importing user model
  final String defaultProfilePicUrl = 'images/chub.jpg';

  const ProfilePicWidget({required this.user});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: SizedBox(
            height:144,
            width: 144,
            child: Container(
              child: ClipOval(
                //check if the profilepic is not null in database and if null then default
                child: user.profilePic != null && user.profilePic.isNotEmpty ? Image.network(user.profilePic, fit: BoxFit.cover,) : Image.asset(defaultProfilePicUrl, fit: BoxFit.cover)
              )
            ),
          ),
             
          
        ),
    );
  }
}