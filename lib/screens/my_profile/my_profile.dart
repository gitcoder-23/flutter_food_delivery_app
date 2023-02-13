import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/components/navigationMenus/drawer_menu.dart';
import 'package:flutter_food_delivery_app/constants/colors.dart';
import 'package:flutter_food_delivery_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

// Stack--> for division and add some image between two section

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    getCurrentUserCall();
    super.initState();
  }

  getCurrentUserCall() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    if (mounted) {
      userProvider.fetchCurrentUserData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      getCurrentUserCall();
    }
  }

  Widget listTile({IconData? iconData, String? title}) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(iconData!),
          title: Text(title!),
          trailing: const Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          'My Profile',
          style: TextStyle(
            color: textColor,
            fontSize: 17,
          ),
        ),
      ),
      body: buildMainProfileBody(),
    );
  }

  Widget buildMainProfileBody() {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return ListView(
      children: [
        SizedBox(
          // color: kGrey,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 100,
                    color: primaryColor,
                  ),
                  Container(
                    height: 619.2,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 250,
                              height: 80,
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userProvider.currentUserData!.userName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(userProvider
                                          .currentUserData!.userEmail),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: primaryColor,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: scaffoldBackgroundColor,
                                      child: Icon(
                                        Icons.edit,
                                        color: primaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        listTile(
                          iconData: Icons.shop_outlined,
                          title: 'My Orders',
                        ),
                        listTile(
                          iconData: Icons.location_on_outlined,
                          title: 'My Delivery Address',
                        ),
                        listTile(
                          iconData: Icons.person_outline,
                          title: 'Refer a Friend',
                        ),
                        listTile(
                          iconData: Icons.file_copy_outlined,
                          title: 'Terms & Conditions',
                        ),
                        listTile(
                          iconData: Icons.policy_outlined,
                          title: 'Privacy Policy',
                        ),
                        listTile(
                          iconData: Icons.add_chart_outlined,
                          title: 'About',
                        ),
                        listTile(
                          iconData: Icons.exit_to_app_outlined,
                          title: 'Logout',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 30),
                child: CircleAvatar(
                  radius: 50,
                  // backgroundColor: primaryColor,
                  backgroundColor: Colors.yellow,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: scaffoldBackgroundColor,
                    backgroundImage: NetworkImage(
                      userProvider.currentUserData!.userImage ??
                          "https://s3.envato.com/files/328957910/vegi_thumb.png",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
