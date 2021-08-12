import 'package:brew_crew/authenticate/authenticate.dart';
import 'package:brew_crew/home/home.dart';
import 'package:brew_crew/models/brewuser.dart';
//import 'package:brew_crew/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BrewUser>(context);
    print(user);
    //return either home or authenticate
    if(user==null){
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}