// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/helpers/functions.dart';
import 'package:flutter_food_delivery_app/providers/user_provider.dart';
import 'package:flutter_food_delivery_app/screens/home_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late UserProvider userProviderState;
  _signinWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // print("@@credential--> ${credential.accessToken}");

      final User? user = (await auth.signInWithCredential(credential)).user;
      print("signed in--> ${user?.displayName}");
      // Add User Data In FireStore
      // userProviderState.addUserData(
      //   currentUser: user!,
      //   userEmail: user.email,
      //   userImage: user.photoURL,
      //   userName: user.displayName,
      // );
      if (user?.displayName != null && credential.accessToken != null) {
        showToast(
          context,
          'Correct credential',
        );
        // Add User Data In FireStore
        userProviderState.addUserData(
          currentUser: user!,
          userEmail: user.email,
          userImage: user.photoURL,
          userName: user.displayName,
        );
        // "pushReplacement" --> can not back prev page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        showToast(
          context,
          'Invalid credential',
        );
      }

      return user;
    } catch (e) {
      print('@@error-> $e');

      showToast(
        context,
        'Something went wrong',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    userProviderState = Provider.of<UserProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('SignIn'),
      // ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/background.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 360,
              width: double.infinity,
              color: const Color(0x00dddcdd),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Sign in to continue'),
                  Text(
                    'Vegi',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.green.shade900,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      // SignInButton(
                      //   Buttons.Apple,
                      //   text: "Sign in with Apple",
                      //   onPressed: () {},
                      // ),
                      SignInButton(
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () {
                          _signinWithGoogle();
                          // _signinWithGoogle().then(
                          //   (value) => Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //       builder: (context) => const HomeScreen(),
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'By signing in you are agreeing to our',
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        'Terms and Pricacy Policy',
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
