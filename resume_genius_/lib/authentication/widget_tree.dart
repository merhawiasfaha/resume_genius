import 'package:resume_genius/authentication/auth.dart';
import 'package:resume_genius/pages/home_page.dart';
import 'package:resume_genius/pages/signin_page.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges, 
      builder: (context, snapshot) { 
        if(snapshot.hasData){
          return const HomePage();
        }else{
          return const SignInPage();
        }
       },

    );
  }
}