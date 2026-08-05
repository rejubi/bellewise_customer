import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/notification_model.dart';


class NotificationTile extends StatelessWidget {

  final NotificationModel notification;

  final VoidCallback onTap;

  final VoidCallback onDelete;


  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDelete,
  });



  @override
  Widget build(BuildContext context) {

    return Dismissible(

      key: ValueKey(
        notification.id,
      ),

      direction:
      DismissDirection.endToStart,


      background: Container(
        alignment: Alignment.centerRight,

        padding:
        const EdgeInsets.only(
          right: 20,
        ),

        color: Colors.red,

        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),


      onDismissed: (_) {

        onDelete();

      },


      child: InkWell(

        onTap: onTap,

        child: Container(

          margin:
          const EdgeInsets.only(
            bottom: 12,
          ),


          padding:
          const EdgeInsets.all(16),


          decoration: BoxDecoration(

            color: notification.isRead
                ? Colors.white
                : AppColors.primary
                .withOpacity(.08),


            borderRadius:
            BorderRadius.circular(16),


            border: Border.all(
              color:
              Colors.grey.shade200,
            ),

          ),



          child: Row(

            crossAxisAlignment:
            CrossAxisAlignment.start,


            children: [


              Container(

                padding:
                const EdgeInsets.all(10),


                decoration:
                BoxDecoration(

                  color:
                  AppColors.primary
                      .withOpacity(.1),

                  shape:
                  BoxShape.circle,

                ),


                child: Icon(
                  Icons.notifications,
                  color:
                  AppColors.primary,
                ),

              ),



              const SizedBox(
                width: 14,
              ),



              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,


                  children: [


                    Text(

                      notification.title,

                      style:
                      TextStyle(

                        fontWeight:
                        notification.isRead
                            ? FontWeight.w500
                            : FontWeight.bold,

                        fontSize: 16,

                      ),

                    ),



                    const SizedBox(
                      height: 6,
                    ),



                    Text(

                      notification.message,

                      style:
                      TextStyle(

                        color:
                        Colors.grey.shade700,

                      ),

                    ),



                    const SizedBox(
                      height: 8,
                    ),



                    Text(

                      _formatDate(
                        notification.createdAt,
                      ),

                      style:
                      TextStyle(

                        fontSize: 12,

                        color:
                        Colors.grey.shade500,

                      ),

                    ),


                  ],

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }





  String _formatDate(
      DateTime date,
      ){

    final now =
    DateTime.now();


    final difference =
    now.difference(date);



    if(difference.inMinutes < 60){

      return "${difference.inMinutes} minutes ago";

    }



    if(difference.inHours < 24){

      return "${difference.inHours} hours ago";

    }



    return
      "${date.day}/${date.month}/${date.year}";

  }

}