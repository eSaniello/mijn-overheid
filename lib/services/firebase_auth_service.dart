import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  FbUser _userFromFirebase(User user) {
    if (user == null) return null;

    return FbUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Stream<FbUser> get onAuthStateChanged {
    // ignore: deprecated_member_use
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<FbUser> signInAnonymously() async {
    final result = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(result.user);
  }

  Future<FbUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<FbUser> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }
}
