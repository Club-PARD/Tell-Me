import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlive/utils/host_util.dart';
import 'package:provider/provider.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'The account already exists with a different credential.'),
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Error occurred while accessing credentials. Try again.'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error occurred using Google Sign-In. Try again.'),
          ),
        );
      }
    }

    return user;
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }
}

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;
  String uid = '';
  static final sStorage = new FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러옴.
    //이때 불러오는 결과의 타입은 String 타입임.
    //(데이터가 없을때는 null을 반환)
    uid = (await sStorage.read(key: "login"))!;
    print(uid);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (uid != null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference Host = FirebaseFirestore.instance.collection('Host');
    final hostProvider = Provider.of<HostProvider>(context, listen: false);

    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _isSigningIn
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffff0c4c8a)),
              )
            : GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height / 812 * 46,
                  width: MediaQuery.of(context).size.width / 375 * 249,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 812 * 24,
                        width: MediaQuery.of(context).size.height / 812 * 24,
                        child: Image.asset('assets/google_login.png'),
                      ),
                      const Text(
                        '구글로 로그인 하기',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  setState(() {
                    _isSigningIn = true;
                  });

                  User? user =
                      await Authentication.signInWithGoogle(context: context);
                  setState(() {
                    _isSigningIn = false;
                  });

                  // 로그인 성공시 uid를 flutter secure storage에 저장
                  await sStorage.write(key: "login", value: user!.uid);

                  if (user != null) {
                    // Check if user's email exists in Firestore 'Host' collection
                    QuerySnapshot snapshot = await FirebaseFirestore.instance
                        .collection('Host')
                        .where('email', isEqualTo: user.email)
                        .limit(1)
                        .get();

                    if (snapshot.docs.isNotEmpty) {
                      // Email exists in Firestore, navigate to '/home'
                      Navigator.pushNamed(context, '/home');
                    } else {
                      // Email does not exist in Firestore, navigate to '/signup1'
                      hostProvider.setEmail(user.email!);
                      Navigator.pushNamed(context, '/signup1');
                    }
                  }
                },
              ));
  }
}
