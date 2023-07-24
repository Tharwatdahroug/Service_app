import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service/Widget/AuthWeight.dart';
import 'package:service/Widget/alertToast.dart';
import 'package:service/Widget/mybutton.dart';
import 'package:service/Widget/textfromfild.dart';
import 'package:service/Provider/AuthPorvider.dart';

class Sigup extends StatelessWidget {
  Sigup({super.key});

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 39, 119, 1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: Image(
                image: const AssetImage("image/sign in.png"),
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "تسجيل مستخدم جديد",
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
                      child: AuthTextField("ادخل الاسم رباعى",
                          Icons.person_outline, false, _namecontroller),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: AuthTextField("ادخل البريد البريد الالكتروني",
                          Icons.email_outlined, false, _emailcontroller),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: AuthTextField("ادخل كلمه المرور",
                          Icons.password_outlined, true, _passwordcontroller),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<AuthProvider>(builder: (context, Auth, child) {
                      return MyButton(
                        name: 'سجل الان',
                        colors: Color.fromRGBO(96, 43, 213, 1),
                        borderRadius: 20,
                        onPressed: () {
                          if (_emailcontroller.text.isNotEmpty &&
                              _passwordcontroller.text.isNotEmpty) {
                            if (_emailcontroller.text.contains("@")) {
                              if (_passwordcontroller.text.length > 8) {
                                Auth.SigupUser(
                                    _namecontroller.text,
                                    _emailcontroller.text,
                                    _passwordcontroller.text,
                                    context);
                              } else {
                                alertToast(
                                    "كلمة المرور ضعيفة !",
                                    Color.fromRGBO(39, 39, 119, 1),
                                    const Color.fromARGB(255, 255, 255, 255));
                              }
                            } else {
                              alertToast(
                                  "البريد الألكتروني غير صالح !",
                                  Color.fromRGBO(39, 39, 119, 1),
                                  const Color.fromARGB(255, 244, 244, 244));
                            }
                          } else {
                            alertToast(
                                "رجاء قم بأدخال كل البيانات !",
                                Color.fromRGBO(96, 43, 213, 1),
                                const Color.fromARGB(255, 255, 254, 254));
                          }
                        },
                        width: size.width / 2,
                        height: 50,
                        colorwrite: Colors.white,
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
