import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../controllers/profile_controller.dart';


class ChangePasswordScreen extends StatefulWidget {

  const ChangePasswordScreen({
    super.key,
  });


  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();

}



class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {


  final ProfileController controller =
  ProfileController();



  final _formKey =
  GlobalKey<FormState>();


  final oldPasswordController =
  TextEditingController();


  final newPasswordController =
  TextEditingController();


  final confirmPasswordController =
  TextEditingController();



  bool loading = false;


  bool hideOld = true;

  bool hideNew = true;

  bool hideConfirm = true;



  @override
  void dispose() {

    oldPasswordController.dispose();

    newPasswordController.dispose();

    confirmPasswordController.dispose();

    super.dispose();

  }




  Future<void> changePassword() async {


    if(!_formKey.currentState!.validate()){

      return;

    }



    setState(() {

      loading = true;

    });



    try {


      await controller.changePassword(

        oldPassword:
        oldPasswordController.text.trim(),


        newPassword:
        newPasswordController.text.trim(),


        confirmPassword:
        confirmPasswordController.text.trim(),

      );



      if(!mounted) return;



      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Password changed successfully",
          ),

        ),

      );



      Navigator.pop(context);



    } catch(e){


      if(!mounted) return;


      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content:
          Text(
            ErrorHandler.getMessage(e),
          ),

        ),

      );


    } finally {


      if(mounted){

        setState(() {

          loading = false;

        });

      }

    }

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor:
      AppColors.background,


      appBar:
      AppBar(

        title:
        const Text(
          "Change Password",
        ),

      ),



      body:
      Form(

        key:
        _formKey,


        child:
        ListView(

          padding:
          const EdgeInsets.all(20),


          children:[



            passwordField(

              controller:
              oldPasswordController,

              label:
              "Current Password",

              hidden:
              hideOld,

              toggle:(){

                setState(() {

                  hideOld =
                  !hideOld;

                });

              },

            ),




            passwordField(

              controller:
              newPasswordController,

              label:
              "New Password",

              hidden:
              hideNew,

              toggle:(){

                setState(() {

                  hideNew =
                  !hideNew;

                });

              },

              validator:(value){

                if(value == null ||
                    value.length < 6){

                  return
                    "Password must be at least 6 characters";

                }

                return null;

              },

            ),




            passwordField(

              controller:
              confirmPasswordController,

              label:
              "Confirm Password",

              hidden:
              hideConfirm,

              toggle:(){

                setState(() {

                  hideConfirm =
                  !hideConfirm;

                });

              },


              validator:(value){


                if(value !=
                    newPasswordController.text){

                  return
                    "Passwords do not match";

                }


                return null;

              },

            ),



            const SizedBox(
              height:30,
            ),



            SizedBox(

              height:55,


              child:
              ElevatedButton(

                onPressed:
                loading
                    ? null
                    : changePassword,


                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  AppColors.primary,


                  foregroundColor:
                  Colors.white,


                  shape:
                  RoundedRectangleBorder(

                    borderRadius:
                    BorderRadius.circular(14),

                  ),

                ),



                child:

                loading

                    ?

                const CircularProgressIndicator(
                  color: Colors.white,
                )

                    :

                const Text(
                  "Update Password",
                  style:
                  TextStyle(
                    fontSize:16,
                  ),
                ),

              ),

            ),


          ],

        ),

      ),

    );

  }





  Widget passwordField({

    required TextEditingController controller,

    required String label,

    required bool hidden,

    required VoidCallback toggle,

    String? Function(String?)? validator,

  }){


    return Padding(

      padding:
      const EdgeInsets.only(
        bottom:18,
      ),


      child:
      TextFormField(

        controller:
        controller,


        obscureText:
        hidden,


        validator:
        validator ??
                (value){

              if(value == null ||
                  value.isEmpty){

                return "$label is required";

              }


              return null;

            },


        decoration:
        InputDecoration(

          labelText:
          label,


          filled:
          true,


          fillColor:
          Colors.white,


          suffixIcon:
          IconButton(

            icon:
            Icon(

              hidden

                  ? Icons.visibility_off

                  : Icons.visibility,

            ),


            onPressed:
            toggle,

          ),


          border:
          OutlineInputBorder(

            borderRadius:
            BorderRadius.circular(14),

          ),

        ),

      ),

    );

  }

}