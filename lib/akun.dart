import 'package:dio/dio.dart';
import 'package:drug_reminder/auth.dart';
import 'package:drug_reminder/dio/repo/auth.dart';
import 'package:drug_reminder/login.dart';
import 'package:drug_reminder/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio/network/api/auth/auth.dart';
import 'dio/network/dio_client.dart';

class akun extends StatefulWidget {
  const akun({Key? key}) : super(key: key);

  @override
  State<akun> createState() => _akunState();
}

class _akunState extends State<akun> {
  String? nama;
  String? nim;
  AuthenticationService service = AuthenticationService(FirebaseAuth.instance);

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    AuthApi authApi = AuthApi(dioClient: dioClient);
    AuthRepository repo = AuthRepository(authApi: authApi);
    String user = await repo.meReq(prefs.getString('token')!);
    setState(() {
      nama = user;
      nim = prefs.getString('nim');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF64FFDA),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => homePage(),
                ));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              await FirebaseAuth.instance.signOut();
              if (await googleSignIn.isSignedIn()) {
                googleSignIn.disconnect();
              }
              if (FirebaseAuth.instance.currentUser == null)
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => login(),
                    ));
            },
          ),
        ],
      ),
      body: Container(
        child: Column(children: [
          Text(
            'User  :$nama',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ]),
      ),
    );
  }
}
