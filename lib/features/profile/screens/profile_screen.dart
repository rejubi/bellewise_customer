import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';
import '../../cart/controllers/cart_state.dart';
import '../../home/widgets/bottom_navigation.dart';
import '../controllers/profile_controller.dart';
import '../models/profile_model.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  final ProfileController controller =
  ProfileController();

  final CartState cartState =
      CartState.instance;

  late Future<ProfileModel> _future;


  @override
  void initState() {
    super.initState();

    _future = controller.loadProfile();
  }


  Future<void> _refresh() async {
    setState(() {
      _future = controller.loadProfile();
    });
  }


  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: cartState,

      builder: (context, _) {

        return Scaffold(

          backgroundColor:
          AppColors.background,


          appBar: AppBar(
            elevation: 0,
            backgroundColor:
            Colors.white,

            centerTitle: true,

            title: const Text(
              "Profile",
            ),
          ),



          bottomNavigationBar:
          HomeBottomNavigation(

            currentIndex: 4,

            onTap: (index) async {

              switch(index) {

                case 0:
                  context.go("/home");
                  break;


                case 1:
                  await context.push(
                    "/orders",
                  );
                  break;


                case 2:
                  await context.push(
                    "/cart",
                  );
                  break;


                case 3:

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Favorites coming soon",
                      ),
                    ),
                  );

                  break;


                case 4:
                  break;
              }
            },
          ),



          body: FutureBuilder<ProfileModel>(

            future: _future,


            builder: (context, snapshot) {


              if(snapshot.connectionState ==
                  ConnectionState.waiting) {

                return const Center(
                  child:
                  CircularProgressIndicator(),
                );
              }



              if(snapshot.hasError) {

                return ErrorView(

                  message:
                  ErrorHandler.getMessage(
                    snapshot.error,
                  ),

                  onRetry:
                  _refresh,
                );
              }



              if(!snapshot.hasData) {

                return const Center(
                  child: Text(
                    "No profile found.",
                  ),
                );
              }



              final profile =
              snapshot.data!;



              return RefreshIndicator(

                onRefresh:
                _refresh,


                child: ListView(

                  padding:
                  const EdgeInsets.all(20),


                  children: [


                    const SizedBox(
                      height: 10,
                    ),



                    ProfileHeader(
                      profile: profile,
                    ),



                    const SizedBox(
                      height: 30,
                    ),

                    ProfileMenuTile(

                      icon:
                      Icons.location_on_outlined,

                      title:
                      "Saved Addresses",


                      onTap: () async {

                        await context.push(
                          "/profile/addresses",
                        );

                      },
                    ),



                    ProfileMenuTile(

                      icon:
                      Icons.notifications_outlined,

                      title:
                      "Notifications",


                      onTap: () async {

                        await context.push(
                          "/profile/notifications",
                        );

                      },
                    ),



                    ProfileMenuTile(

                      icon:
                      Icons.lock_outline,

                      title:
                      "Change Password",


                      onTap: () async {

                        await context.push(
                          "/profile/change-password",
                        );

                      },
                    ),



                    ProfileMenuTile(

                      icon:
                      Icons.support_agent_outlined,

                      title:
                      "Help & Support",


                      onTap: () async {

                        await context.push(
                          "/profile/help",
                        );

                      },
                    ),



                    ProfileMenuTile(

                      icon:
                      Icons.info_outline,

                      title:
                      "About BelleWise",


                      onTap: () async {

                        await context.push(
                          "/profile/about",
                        );

                      },
                    ),



                    ProfileMenuTile(

                      icon:
                      Icons.logout,

                      title:
                      "Logout",

                      color:
                      Colors.red,


                      onTap: () async {

                        try {

                          // 1. Clear the customer's server-side cart
                          // while the access token is still available.
                          await CartState.instance.clearCart();

                          // 2. Now remove the JWT tokens.
                          await controller.logout();

                          // 3. Go to login.
                          if (!mounted) return;

                          context.go("/login");

                        } catch (e) {

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.toString(),
                              ),
                            ),
                          );

                        }

                      },
                    ),



                    const SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}