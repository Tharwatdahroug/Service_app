import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:service/Provider/AuthPorvider.dart';
import 'package:service/Screen/Auth/Login.dart';
import 'package:service/Screen/Auth/Sigup.dart';
import 'package:service/Widget/mybutton.dart';
import 'package:provider/provider.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({super.key});
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 39, 119, 1),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Image(
                  image: const AssetImage("image/s.png"),
                  width: size.width,
                  height: size.height * 0.25,
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Text(""),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 0,
              child: MyButton(
                name: "تسجيل الدخول",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                colors: Color.fromRGBO(96, 43, 213, 1),
                height: 55,
                width: size.width * 0.70,
                borderRadius: 20,
                colorwrite: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 0,
              child: MyButton(
                name: "تسجيل مستخدم جديد",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sigup()));
                },
                colors: Color.fromRGBO(255, 255, 255, 1),
                height: 55,
                width: size.width * 0.70,
                borderRadius: 20,
                colorwrite: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
                flex: 0,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    UserCredential credential = await signInWithGoogle();
                    print(credential);
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage("image/3.png"),
                          height: 35.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
