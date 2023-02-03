import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Home  extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("E X A M P L E",style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        elevation: 20,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              child:const Text("Sign Out"),
            ),
          ),
          Text(
            user!.email!,
            style: const TextStyle(fontSize: 25.0),
          ),
        ],
      ),
    );
  }
}
