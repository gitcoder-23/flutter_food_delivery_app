import 'package:flutter/material.dart';

class LandingLoading extends StatelessWidget {
  const LandingLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  const Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 14, 196, 54)),
                      )
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
