import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';
import '../controllers/profile_controller.dart';
import '../models/profile_model.dart';
import '../widgets/profile_text_field.dart';
import '../widgets/save_profile_button.dart';


class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({
    super.key,
  });


  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}



class _EditProfileScreenState
    extends State<EditProfileScreen> {


  final ProfileController controller =
  ProfileController();


  final _formKey =
  GlobalKey<FormState>();


  final TextEditingController
  _addressController =
  TextEditingController();


  final TextEditingController
  _cityController =
  TextEditingController();


  final TextEditingController
  _stateController =
  TextEditingController();



  bool _loading = true;

  bool _saving = false;

  String? _error;



  @override
  void initState() {

    super.initState();

    _loadProfile();

  }



  @override
  void dispose() {

    _addressController.dispose();

    _cityController.dispose();

    _stateController.dispose();

    super.dispose();

  }




  Future<void> _loadProfile() async {

    try {

      final profile =
      await controller.loadProfile();


      _populate(profile);


    } catch (e) {

      _error =
          ErrorHandler.getMessage(e);

    } finally {

      if (mounted) {

        setState(() {

          _loading = false;

        });

      }

    }

  }





  void _populate(ProfileModel profile) {

    _addressController.text =
        profile.address;


    _cityController.text =
        profile.city;


    _stateController.text =
        profile.state;

  }





  Future<void> _refresh() async {

    setState(() {

      _loading = true;

      _error = null;

    });


    await _loadProfile();

  }





  @override
  Widget build(BuildContext context) {


    if (_loading) {

      return Scaffold(

        backgroundColor:
        AppColors.background,


        appBar: AppBar(
          title:
          const Text(
            "Edit Delivery Information",
          ),
        ),


        body:
        const Center(
          child:
          CircularProgressIndicator(),
        ),

      );

    }




    if (_error != null) {


      return Scaffold(

        appBar: AppBar(
          title:
          const Text(
            "Edit Delivery Information",
          ),
        ),


        body:
        ErrorView(
          message: _error!,
          onRetry: _refresh,
        ),

      );

    }




    return Scaffold(

      backgroundColor:
      AppColors.background,


      appBar: AppBar(

        title:
        const Text(
          "Edit Delivery Information",
        ),

      ),




      body: SafeArea(

        child: Form(

          key: _formKey,


          child: ListView(

            padding:
            const EdgeInsets.all(20),



            children: [



              const Text(

                "Delivery Information",

                style:
                TextStyle(

                  fontSize: 18,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),



              const SizedBox(
                height: 20,
              ),





              ProfileTextField(

                controller:
                _addressController,


                label:
                "Delivery Address",


                maxLines:
                3,


                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {

                    return
                      "Delivery address is required";

                  }


                  return null;

                },

              ),






              ProfileTextField(

                controller:
                _cityController,


                label:
                "City",



                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {

                    return
                      "City is required";

                  }


                  return null;

                },

              ),






              ProfileTextField(

                controller:
                _stateController,


                label:
                "State",



                validator: (value) {

                  if (value == null ||
                      value.trim().isEmpty) {

                    return
                      "State is required";

                  }


                  return null;

                },

              ),




              const SizedBox(
                height: 30,
              ),





              SaveProfileButton(

                loading:
                _saving,



                onPressed: () async {


                  if (!_formKey.currentState!
                      .validate()) {

                    return;

                  }



                  setState(() {

                    _saving = true;

                  });





                  try {


                    await controller.updateProfile(

                      address:
                      _addressController.text.trim(),


                      city:
                      _cityController.text.trim(),


                      state:
                      _stateController.text.trim(),

                    );




                    if (!mounted) return;



                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(

                        content:
                        Text(
                          "Delivery information updated.",
                        ),

                      ),

                    );



                    context.pop(true);



                  } catch (e) {


                    if (!mounted) return;



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


                    if (mounted) {

                      setState(() {

                        _saving = false;

                      });

                    }


                  }


                },

              ),



              const SizedBox(
                height: 24,
              ),



            ],

          ),

        ),

      ),

    );

  }

}