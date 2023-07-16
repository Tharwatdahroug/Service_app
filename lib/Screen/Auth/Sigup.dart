import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service/Widget/AuthWeight.dart';
import 'package:service/Widget/mybutton.dart';
import 'package:service/Widget/textfromfild.dart';
import 'package:service/Provider/AuthPorvider.dart';

class Sigup extends StatelessWidget {
  const Sigup({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _namecontroller = TextEditingController();
    final TextEditingController _emailcontroller = TextEditingController();
    final TextEditingController _passwordcontroller = TextEditingController();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 39, 119, 1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: Image(
                image: const AssetImage("image/r.png"),
                width: size.width,
                height: size.height * 0.25,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Get Started",
                            style: TextStyle(
                              color: Color.fromRGBO(96, 43, 213, 1),
                              fontSize: size.height / 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: AuthTextField("Enter UserName",
                          Icons.person_outline, false, _namecontroller),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: AuthTextField("Enter Email", Icons.person_outline,
                          false, _emailcontroller),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: AuthTextField("Enter Password",
                          Icons.person_outline, true, _passwordcontroller),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<AuthProvider>(builder: (context, Auth, child) {
                      return MyButton(
                        name: 'SigUp',
                        colors: Color.fromRGBO(96, 43, 213, 1),
                        borderRadius: 20,
                        onPressed: () {
                          Auth.SigupUser(
                            _namecontroller.text,
                            _emailcontroller.text,
                            _passwordcontroller.text,
                            "Male",
                          );
                        },
                        width: size.width / 2,
                        height: 50,
                      );
                    }),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
