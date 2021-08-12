import 'package:brew_crew/models/brewuser.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  BrewUser _userfromFirebaseUser(User user) {
   return user !=null ? BrewUser(uid:user.uid) : null;
  }

  //auth change user stream
  Stream<BrewUser> get user {
    return _auth.authStateChanges().map(_userfromFirebaseUser);
    //same as _auth.authStateChanges().map((User user) => _userfromFirebaseUser(user));
  }

  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userfromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
//sign in with email & password
Future signinwithEmailAndPassword(String email,String password) async{
  try{
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    return _userfromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}

//register with email & password
Future registerwithEmailAndPassword(String email,String password) async{
  try{
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    //create a new document for user with the uid
    await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
    return _userfromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}

//sign out
Future signOut() async{
  try{
    return await _auth.signOut();
  }catch(e){
    print(e.toString());
    return null;
  }
}
}
