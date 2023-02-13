import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// handleAuthState() {
//   return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.hasData) {
//           return HomePage();
//         } else {
//           return const LoginPage();
//         }
//       });
// }

signinWithGoogle() async {
  // Trigger the autentication flow
  final GoogleSignInAccount? gooleUser =
      await GoogleSignIn(scopes: <String>['email']).signIn();

  // Obtain The auth Details
  final GoogleSignInAuthentication googleAuth = await gooleUser!.authentication;

  // Create new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once siged in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

signOut() {
  FirebaseAuth.instance.signOut();
}
