import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> handleSignIn() async {
    print("Handle sign is is invoked");
    FirebaseUser user;

    bool _isSignedIn = await _googleSignIn.isSignedIn();
    print("Value of bool " + _isSignedIn.toString());

    if (_isSignedIn) {
      user = await _firebaseAuth.currentUser();
      return user;
    }
    GoogleSignInAccount _googleUser ;
    try{
      _googleUser = await _googleSignIn?.signIn();
    }catch(error){
      print("Error Caught");
      return null;
    }
    if(_googleUser == null) return null;
    final GoogleSignInAuthentication _googleAuth =
        await _googleUser?.authentication;
    if(_googleAuth == null) return null;

    final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

    user = (await _firebaseAuth.signInWithCredential(_authCredential)).user;

    return user;
  }
  Future<FirebaseUser> getCurrentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser() ;
    return user ;
  }

  handleSignOut() async{
    _googleSignIn.disconnect();
    await _firebaseAuth.signOut().then((value){
      print("User is Signed out");
    }) ;
  }
}
