import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:service/Widget/alertToast.dart';
import 'package:service/model/UserModel.dart';

import '../Screen/home/Homepage.dart';

class AuthProvider with ChangeNotifier {
  final UsersRef =
      FirebaseFirestore.instance.collection('users').withConverter<Users>(
            fromFirestore: (snapshot, _) => Users.fromJson(snapshot.data()!),
            toFirestore: (Users, _) => Users.toJson(),
          );
  Future<void> SigupUser(
    String name,
    String email,
    String Password,
    BuildContext context,
  ) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: Password)
          .then((value) {
        print("Created New Account");
        UsersRef.add(
          Users(
            name: name,
            email: email,
          ),
        ).then((value) => print("User Added"));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        alertToast(
            "البريد الألكتروني غير صالح !",
            Color.fromRGBO(39, 39, 119, 1),
            const Color.fromARGB(255, 244, 244, 244));
      } else if (error.code == 'email-already-in-use') {
        alertToast(
            "البريد الألكتروني غير صالح !",
            Color.fromRGBO(39, 39, 119, 1),
            const Color.fromARGB(255, 244, 244, 244));
      }
    }
// ignore: unused_local_variable, non_constant_identifier_names

    notifyListeners();
  }

  Future<void> Login(
    String email,
    String Password,
    BuildContext context,
  ) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: Password)
        .then((value) {
      print("Created New Account");

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    });
    notifyListeners();
  }

  Future<void> signInWithGoogle(context) async {
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
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // User? user = await FirebaseAuth.instance.currentUser;
    if (userCredential.user != null) {
      UsersRef.add(
        Users(
          name: userCredential.user!.displayName.toString(),
          email: userCredential.user!.email.toString(),
        ),
      ).then((value) => print("User Added"));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    }

    notifyListeners();
  }

  // List<Product> productModelList = [];
  // late Product productModel;
  // Future<void> getProductData() async {
  //   List<Product> newList = [];
  //   QuerySnapshot userSnapShot =
  //       await FirebaseFirestore.instance.collection("Product").get();
  //   userSnapShot.docs.forEach(
  //     (element) {
  //       productModel = Product(
  //         name: (element.data() as dynamic)["name"],
  //         description: (element.data() as dynamic)["description"],
  //         Colors: (element.data() as dynamic)["colors"],
  //         Sizes: (element.data() as dynamic)["sizes"],
  //         discount: (element.data() as dynamic)["discount"],
  //         image: (element.data() as dynamic)["images"],
  //         price: (element.data() as dynamic)["price"],
  //         priceFAC: (element.data() as dynamic)["priceFAC"],
  //         productCode: (element.data() as dynamic)["productCode"],
  //         shop: (element.data() as dynamic)["Shop"],
  //         subCategory: (element.data() as dynamic)["subCategory"],
  //       );
  //       newList.add(productModel);

  //       productModelList = newList;
  //       notifyListeners();
  //     },
  //   );
  // }

  // List<Product> get getProductModelList {
  //   return productModelList;
  // }

  // List<Category> CategoryModelList = [];
  // late Category CategoryModel;
  // Future<void> getCategoryData() async {
  //   List<Category> newList = [];
  //   QuerySnapshot userSnapShot =
  //       await FirebaseFirestore.instance.collection("Category").get();
  //   userSnapShot.docs.forEach(
  //     (element) {
  //       CategoryModel = Category(
  //         name: (element.data() as dynamic)["name"],
  //       );
  //       newList.add(CategoryModel);

  //       CategoryModelList = newList;
  //     },
  //   );
  // }

  // List<Category> get getUserModelList {
  //   return CategoryModelList;
}
