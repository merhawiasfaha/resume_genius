import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:resume_genius/authentication/auth.dart';
import 'package:resume_genius/pages/full_name_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  bool isLoading = false;

  Future<void> signOut() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    await Auth().signOut();
    // setState(() {
    //   isLoading = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResumeGenius'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async{
              await signOut();
              setState(() {
                isLoading = false;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to ResumeGenius!',
                  style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 64, 30), fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FullNamePage()),
                    );
                  },
                  child: const Text('Start Building Your Resume'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: isLoading
                ? Container(
                    // padding:EdgeInsetsGeometry. ,
                    color: Colors.white, 
                    child: const SpinKitThreeBounce(
                      color: Color.fromARGB(255, 78, 145, 199),
                      size: 25,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
