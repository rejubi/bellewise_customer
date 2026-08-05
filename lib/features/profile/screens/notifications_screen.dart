import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';

import '../controllers/notification_controller.dart';
import '../models/notification_model.dart';
import '../widgets/notification_tile.dart';



class NotificationsScreen extends StatefulWidget {

  const NotificationsScreen({
    super.key,
  });


  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();

}



class _NotificationsScreenState
    extends State<NotificationsScreen> {


  final NotificationController controller =
  NotificationController();



  late Future<List<NotificationModel>>
  _future;



  @override
  void initState() {

    super.initState();

    _future =
        controller.loadNotifications();

  }




  Future<void> _refresh() async {

    setState(() {

      _future =
          controller.loadNotifications();

    });

  }





  Future<void> _markRead(
      NotificationModel notification,
      ) async {


    if(notification.isRead){

      return;

    }


    await controller.markRead(
      notification.id,
    );


    _refresh();

  }





  Future<void> _delete(
      int id,
      ) async {


    await controller.deleteNotification(
      id,
    );


    _refresh();

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
          "Notifications",
        ),


        actions: [

          TextButton(

            onPressed: () async {

              await controller.markAllRead();

              _refresh();

            },


            child:
            const Text(
              "Read all",
            ),

          ),

        ],

      ),



      body:
      FutureBuilder<List<NotificationModel>>(

        future:
        _future,


        builder:
            (context, snapshot){


          if(snapshot.connectionState ==
              ConnectionState.waiting){

            return const Center(
              child:
              CircularProgressIndicator(),
            );

          }



          if(snapshot.hasError){

            return ErrorView(

              message:
              ErrorHandler.getMessage(
                snapshot.error,
              ),

              onRetry:
              _refresh,

            );

          }



          final notifications =
              snapshot.data ?? [];



          if(notifications.isEmpty){

            return const Center(

              child:
              Text(
                "No notifications yet.",
              ),

            );

          }




          return RefreshIndicator(

            onRefresh:
            _refresh,


            child:
            ListView.builder(

              padding:
              const EdgeInsets.all(16),


              itemCount:
              notifications.length,


              itemBuilder:
                  (context,index){


                final item =
                notifications[index];


                return NotificationTile(

                  notification:
                  item,


                  onTap: (){

                    _markRead(
                      item,
                    );

                  },


                  onDelete: (){

                    _delete(
                      item.id,
                    );

                  },

                );

              },

            ),

          );


        },

      ),

    );

  }

}