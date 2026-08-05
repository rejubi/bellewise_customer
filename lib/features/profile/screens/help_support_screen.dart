import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../controllers/profile_controller.dart';


class HelpSupportScreen extends StatefulWidget {

  const HelpSupportScreen({
    super.key,
  });


  @override
  State<HelpSupportScreen> createState() =>
      _HelpSupportScreenState();

}



class _HelpSupportScreenState
    extends State<HelpSupportScreen> {


  final ProfileController controller =
  ProfileController();


  late Future<Map<String,dynamic>> future;



  @override
  void initState() {

    super.initState();

    future =
        controller.loadHelpSupport();

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
          "Help & Support",
        ),

      ),



      body:
      FutureBuilder<Map<String,dynamic>>(

        future:
        future,


        builder:(context,snapshot){


          if(snapshot.connectionState ==
              ConnectionState.waiting){

            return const Center(
              child:
              CircularProgressIndicator(),
            );

          }



          if(snapshot.hasError){

            return Center(

              child:
              Text(
                snapshot.error.toString(),
              ),

            );

          }



          final data =
          snapshot.data!;



          return ListView(

            padding:
            const EdgeInsets.all(20),


            children:[


              Card(

                child:
                ListTile(

                  leading:
                  const Icon(
                    Icons.email_outlined,
                  ),

                  title:
                  const Text(
                    "Email",
                  ),

                  subtitle:
                  Text(
                    data["email"] ?? "",
                  ),

                ),

              ),



              Card(

                child:
                ListTile(

                  leading:
                  const Icon(
                    Icons.phone_outlined,
                  ),

                  title:
                  const Text(
                    "Phone",
                  ),

                  subtitle:
                  Text(
                    data["phone"] ?? "",
                  ),

                ),

              ),



              Card(

                child:
                Padding(

                  padding:
                  const EdgeInsets.all(16),

                  child:
                  Text(
                    data["message"] ?? "",
                  ),

                ),

              ),

            ],

          );

        },

      ),

    );

  }

}