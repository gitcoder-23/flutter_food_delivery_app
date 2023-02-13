import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/auth/signin.dart';
import 'package:flutter_food_delivery_app/providers/review_cart_provider.dart';
import 'package:flutter_food_delivery_app/providers/user_provider.dart';
import 'package:flutter_food_delivery_app/screens/home_screen.dart';
import 'package:flutter_food_delivery_app/screens/my_profile/my_profile.dart';
import 'package:flutter_food_delivery_app/screens/review_cart/review_cart.dart';
import 'package:flutter_food_delivery_app/screens/wishList/wish_list.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
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

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    ReviewCartProvider reviewCartProvider =
        Provider.of<ReviewCartProvider>(context);

    return Drawer(
      child: Container(
        color: const Color(0xffd1ad17),
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    radius: 43,
                    // child: CircleAvatar(
                    //   radius: 40,
                    //   backgroundColor: Colors.red,
                    // ),

                    child: CircleAvatar(
                      backgroundColor: Colors.yellow,
                      backgroundImage: NetworkImage(
                        userProvider.currentUserData?.userImage ??
                            "https://s3.envato.com/files/328957910/vegi_thumb.png",
                      ),
                      radius: 40,
                    ),

                    // child: CircleAvatar(
                    //   backgroundColor: Colors.yellow,
                    //   backgroundImage:
                    //       widget.userProviderGetCurrent!.userImage.isNotEmpty
                    //           ? NetworkImage(
                    //               widget.userProviderGetCurrent!.userImage,
                    //             )
                    //           : const NetworkImage(
                    //               "https://s3.envato.com/files/328957910/vegi_thumb.png",
                    //             ),
                    //   radius: 40,
                    // ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Welcome'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProvider.currentUserData!.userName,
                            softWrap: true,
                          ),
                          // Text(widget.userProviderGetCurrent!.userEmail),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 30,
                        child: MaterialButton(
                            onPressed: () {
                              print('logout');
                              FirebaseAuth.instance.signOut();

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignIn(),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(width: 2),
                            ),
                            child: const Text('Logout')),
                      )
                    ],
                  ),
                ],
              ),
            ),
            drawerListTile(
                onTapMenu: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                iconData: Icons.home_outlined,
                title: 'Home'),
            drawerListTile(
                onTapMenu: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ReviewCart(reviewCartProvider: reviewCartProvider),
                    ),
                  );
                },
                iconData: Icons.shop_outlined,
                title: 'Review Cart'),
            drawerListTile(
                onTapMenu: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyProfile(),
                    ),
                  );
                },
                iconData: Icons.person_outline,
                title: 'My Profile'),
            drawerListTile(
                onTapMenu: () {
                  print('Navigator--> $Navigator');
                },
                iconData: Icons.notifications_outlined,
                title: 'Notification'),
            drawerListTile(
                onTapMenu: () {
                  print('Navigator--> $Navigator');
                },
                iconData: Icons.star_outlined,
                title: 'Rating & Review'),
            drawerListTile(
                onTapMenu: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WishList(),
                    ),
                  );
                },
                iconData: Icons.favorite_outline,
                title: 'Wishlist'),
            drawerListTile(
                onTapMenu: () {
                  print('Navigator--> $Navigator');
                },
                iconData: Icons.copy_outlined,
                title: 'Raise a Complaint'),
            drawerListTile(
                onTapMenu: () {
                  print('Navigator--> $Navigator');
                },
                iconData: Icons.format_quote_outlined,
                title: 'FAQs'),
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Contact Support'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Text('Call us:'),
                      Text("+91-7898574859"),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        Text('Mail us:'),
                        SizedBox(
                          width: 10,
                        ),
                        Text("support@test.com"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawerListTile(
      {IconData? iconData, String? title, Function? onTapMenu}) {
    return ListTile(
      onTap: onTapMenu ?? onTapMenu!(),
      leading: Icon(
        iconData,
        size: 32,
      ),
      title: Text(
        title ?? '',
        style: const TextStyle(
          color: Colors.black87,
        ),
      ),
    );
  }
}
