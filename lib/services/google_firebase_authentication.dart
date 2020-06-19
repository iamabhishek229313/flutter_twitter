import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> handleSignIn() async {
    FirebaseUser user;

    bool _isSignedIn = await _googleSignIn.isSignedIn();

    if (_isSignedIn) {
      user = await _firebaseAuth.currentUser();
      return user;
    }

    final GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication _googleAuth =
        await _googleUser.authentication;

    final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

    user = (await _firebaseAuth.signInWithCredential(_authCredential)).user;

    return user;
  }
  
  Future handleSignOut() async{
    await _firebaseAuth.signOut() ;
    return null ;
  }
}
