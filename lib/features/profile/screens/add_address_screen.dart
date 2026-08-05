import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../controllers/address_controller.dart';


class AddAddressScreen extends StatefulWidget {

  const AddAddressScreen({
    super.key,
  });


  @override
  State<AddAddressScreen> createState() =>
      _AddAddressScreenState();

}



class _AddAddressScreenState
    extends State<AddAddressScreen> {


  final AddressController controller =
  AddressController();



  final _formKey =
  GlobalKey<FormState>();



  final recipientController =
  TextEditingController();


  final phoneController =
  TextEditingController();


  final addressController =
  TextEditingController();


  final cityController =
  TextEditingController();


  final stateController =
  TextEditingController();


  bool saving = false;
  String selectedType = "HOME";


  @override
  void dispose() {

    recipientController.dispose();

    phoneController.dispose();

    addressController.dispose();

    cityController.dispose();

    stateController.dispose();


    super.dispose();

  }



  Future<void> save() async {


    if(!_formKey.currentState!.validate()){

      return;

    }



    setState(() {

      saving = true;

    });



    try {


      await controller.createAddress({

        "title": selectedType,

        "recipient_name":
        recipientController.text.trim(),

        "phone_number":
        phoneController.text.trim(),

        "address":
        addressController.text.trim(),

        "city":
        cityController.text.trim(),

        "state":
        stateController.text.trim(),

        "landmark":
        "",

        "is_default":
        false,

      });



      if(!mounted) return;



      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Address saved successfully",
          ),

        ),

      );



      context.pop(true);



    } catch(e){


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

          saving = false;

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
          "Add Address",
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



            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(
                labelText: "Address Type",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "HOME",
                  child: Text("Home"),
                ),
                DropdownMenuItem(
                  value: "OFFICE",
                  child: Text("Office"),
                ),
                DropdownMenuItem(
                  value: "OTHER",
                  child: Text("Other"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
            ),
            const SizedBox(height: 18),


            field(
              recipientController,
              "Recipient Name",
            ),


            field(
              phoneController,
              "Phone Number",
              keyboard:
              TextInputType.phone,
            ),


            field(
              addressController,
              "Address",
              maxLines:3,
            ),


            field(
              cityController,
              "City",
            ),


            field(
              stateController,
              "State",
            ),



            const SizedBox(
              height:30,
            ),



            SizedBox(

              height:55,


              child:
              ElevatedButton(

                onPressed:
                saving
                    ? null
                    : save,


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

                saving

                    ?

                const CircularProgressIndicator(
                  color: Colors.white,
                )

                    :

                const Text(
                  "Save Address",
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




  Widget field(
      TextEditingController controller,
      String label,{
        TextInputType keyboard =
            TextInputType.text,
        int maxLines = 1,
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


        keyboardType:
        keyboard,


        maxLines:
        maxLines,


        validator:(value){


          if(value == null ||
              value.trim().isEmpty){

            return "$label is required";

          }


          return null;

        },


        decoration:
        InputDecoration(

          labelText:
          label,


          filled:true,


          fillColor:
          Colors.white,


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