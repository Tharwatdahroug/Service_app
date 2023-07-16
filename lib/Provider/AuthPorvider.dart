// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:service/model/UserModel.dart';

class AuthProvider with ChangeNotifier {
  Future<void> SigupUser(
    String name,
    String email,
    String Password,
    String type,
  ) async {
    await FirebaseAuth.instance
        // ignore: avoid_print
        .createUserWithEmailAndPassword(email: email, password: Password)
        .then((value) => print("UserSigup"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to Sigup user: $error"));
// ignore: unused_local_variable
    final UsersRef =
        FirebaseFirestore.instance.collection('users').withConverter<Users>(
              fromFirestore: (snapshot, _) => Users.fromJson(snapshot.data()!),
              toFirestore: (Users, _) => Users.toJson(),
            );
    await UsersRef.add(
      Users(name: name, email: email, type: type),
    )
        // ignore: avoid_print
        .then((value) => print("User Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add user: $error"));

    notifyListeners();
  }

  Future<void> Login(
    String email,
    String Password,
  ) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: Password)
        .then((value) => print("UserLogin Scssed"))
        .catchError((error) => print("Failed to Login user: $error"));
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
