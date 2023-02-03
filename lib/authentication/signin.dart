import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplefireauth/authentication/signup.dart';
import '../main.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obSecure = true;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0,bottom: 30),
            child: Text(
              "Sign In",
              style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              obscureText: _obSecure,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(_obSecure ? Icons.visibility : Icons.visibility_off),
                  onPressed: (){
                    setState(() {
                      _obSecure = !_obSecure;
                    });
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: TextButton(
                    onPressed: (){},
                    child: Text("Reset Password",style: GoogleFonts.lato(
                        fontSize: 18.0,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold
                    ),)
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: signIn,
                  child: Text("Sign In",
                    style: GoogleFonts.lato(
                        fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold
                    ),
                  ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("I'm a new member?",
                  style: GoogleFonts.lato(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp())
                    );
                  },
                  child: Text("SignUp",style: GoogleFonts.lato(
                      fontSize: 18.0,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold
                  ),)
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

}
