import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplefireauth/Authentication/signin.dart';
import '../main.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObsecure = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30),
              child: Text(
                "Sign Up",
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value){
                  if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                    return "Enter your correct email address";
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 18),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: _isObsecure,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _isObsecure = !_isObsecure;
                      });
                    },
                    icon: Icon(_isObsecure ? Icons.visibility : Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: signUp,
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.lato(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.lato(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                    },
                    child: Text(
                      "SignIn",
                      style: GoogleFonts.lato(
                          fontSize: 18.0,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
