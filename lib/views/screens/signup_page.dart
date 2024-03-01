import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_cart/helpers/firestore_helper.dart';
import 'package:my_cart/models/auth_model.dart';
import '../../helpers/auth_helper.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green, Colors.teal],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person_add,
                    color: Colors.green,
                    size: 50.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.person, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      print('Enter email');
                    }
                  },
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.email, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      print('Enter a new password');
                    }
                  },
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter a new password',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      print('Enter a new password');
                    }
                  },
                  controller: cPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Conform Password',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      AuthHelper.authHelper.signupWithEmailPassword(
                          email: email.text, password: password.text);
                      if (password.text == cPassword.text) {
                        User? user = await AuthHelper.authHelper
                            .loginWithEmailPassword(
                                email: email.text, password: password.text);

                        UserModel userModel = UserModel(
                          email: email.text,
                          password: password.text,
                          id: user!.uid,
                        );

                        if (user.email != null) {
                          FirebaseHelper.firebaseHelper
                              .addData(userModel: userModel)
                              .then(
                                (value) => Navigator.of(context)
                                    .pushReplacementNamed('/'),
                              );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("not done"),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
