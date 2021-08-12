import 'package:brew_crew/models/brewuser.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  }
  catch(e)
  {print(e.toString());}
   runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<BrewUser>.value(
      value: AuthService().user,
          child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}