import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../controllers/profile_controller.dart';



class AboutScreen extends StatefulWidget {

  const AboutScreen({
    super.key,
  });


  @override
  State<AboutScreen> createState() =>
      _AboutScreenState();

}



class _AboutScreenState
    extends State<AboutScreen> {


  final ProfileController controller =
  ProfileController();


  late Future<Map<String,dynamic>> future;



  @override
  void initState(){

    super.initState();

    future =
        controller.loadAbout();

  }



  @override
  Widget build(BuildContext context){


    return Scaffold(

      backgroundColor:
      AppColors.background,


      appBar:
      AppBar(

        title:
        const Text(
          "About BelleWise",
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



          return Padding(

            padding:
            const EdgeInsets.all(20),


            child:
            Card(

              child:
              Padding(

                padding:
                const EdgeInsets.all(20),


                child:
                Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,


                  children:[


                    Text(

                      data["title"] ??
                          "BelleWise",

                      style:
                      const TextStyle(

                        fontSize:22,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),



                    const SizedBox(
                      height:20,
                    ),



                    Text(

                      data["description"] ??
                          "",

                      style:
                      const TextStyle(

                        fontSize:16,

                      ),

                    ),

                  ],

                ),

              ),

            ),

          );


        },

      ),

    );

  }

}