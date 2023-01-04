import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'logout.dart';

class login extends StatefulWidget {
  @override
  login_State createState() => login_State();
}

class login_State extends State<login> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');
      print('photoUrl = ${googleUser.photoUrl}');
      print('serverAuthCode = ${googleUser.serverAuthCode}');
    }

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<OAuthCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    // final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // nonce: nonce,
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: "com.bbsoft.study.canko",
          redirectUri: Uri.parse(
              "https://thin-savory-frigate.glitch.me/callbacks/sign_in_with_apple"),
        ));

    final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode);

    print('familyName = ${appleCredential.familyName}');
    print('givenName = ${appleCredential.givenName}');
    print('email = ${appleCredential.email}');
    print('id = ${appleCredential.userIdentifier}');
    // print('photoUrl = ${appleUser.photoUrl}');
    print('serverAuthCode = ${appleCredential.authorizationCode}');

    return oauthCredential;
  }
//   Future<UserCredential> signInWithApple() async {
//   final appleCredential = await SignInWithApple.getAppleIDCredential(
//     scopes: [
//       AppleIDAuthorizationScopes.email,
//       AppleIDAuthorizationScopes.fullName,
//     ],
//   );

//   // Create an `OAuthCredential` from the credential returned by Apple.
//   final oauthCredential = OAuthProvider("apple.com").credential(
//     idToken: appleCredential.identityToken,
//     accessToken: appleCredential.authorizationCode,
//   );

//   // Sign in the user with Firebase. If the nonce we generated earlier does
//   // not match the nonce in `appleCredential.identityToken`, sign in will fail.
//   return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: const Color(0xFFFFFFFF), // Navigation bar
            statusBarColor: const Color(0xFFFFFFFF), // Status bar
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            color: const Color(0xFFFFFFFF),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: 131,
                  height: 37,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/logo_1.png"),
                    ),
                  ),
                ),
                SizedBox(height: 85),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Logout()));
                    // Navigator.pushNamed(context, "/container");

                    signInWithGoogle();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Image.asset(
                      'images/google.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Logout()));
                    // Navigator.pushNamed(context, "/container");
                    signInWithApple();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Image.asset(
                      'images/apple.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/container");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Image.asset(
                      'images/facebook.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/container");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: Image.asset(
                      'images/guest.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  width: MediaQuery.of(context).size.width - 80,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Help",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
