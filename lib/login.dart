import 'package:dio/dio.dart';
import 'package:drug_reminder/akun.dart';
import 'package:drug_reminder/auth.dart';
import 'package:drug_reminder/dio/network/api/auth/auth.dart';
import 'package:drug_reminder/dio/network/dio_client.dart';
import 'package:drug_reminder/dio/repo/auth.dart';
import 'package:drug_reminder/main.dart';
import 'package:drug_reminder/model_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:drug_reminder/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> with InputValidationMixin {
  final List<Map<String, dynamic>> dummydata = DummyData.data;
  final formGlobalKey = GlobalKey<FormState>();
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  // void getdata() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   int? currentid = prefs.getInt('id');
  //   for (var i = 0; i < dummydata.length; i++) {
  //     if (currentid != null && currentid == dummydata[i]['id']) {
  //       prefs.setString('nama', dummydata[i]['nama']);
  //       prefs.setString('nim', dummydata[i]['Nim']);
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => akun(),
  //           ));
  //     }
  //   }
  // }

  void execLogin(String email, String password) async {
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    AuthApi authApi = AuthApi(dioClient: dioClient);
    AuthRepository repo = AuthRepository(authApi: authApi);
    try {
      ModelAuth logins = await repo.loginReq(email, password);
      String getName = await repo.meReq(logins.access_token);
      final prefs = await SharedPreferences.getInstance();
      Navigator.pop(context);
      prefs.setString("token", logins.access_token);
      prefs.setString("name", getName);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => akun(),
          ),
          (Route<dynamic> route) => false);
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Login Failed"),
              content: const Text("Email atau password tidak ditemukan!!"),
              actions: <Widget>[
                FlatButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      AuthenticationService service =
          AuthenticationService(FirebaseAuth.instance);

      if (service.firebaseAuth.currentUser != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const akun(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formGlobalKey,
        child: Container(
          margin: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Text(
                "Welcome on board",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                controller: usernamecontroller,
                validator: (usernamecontroller) {
                  if (isEmailValid(usernamecontroller!))
                    return null;
                  else
                    return 'Masukkan format email yang valid';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Passsword'),
                controller: passwordcontroller,
                validator: (passwordcontroller) {
                  if (isPasswordValid(passwordcontroller!))
                    return null;
                  else
                    return 'masukkan password yang valid';
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    execLogin(usernamecontroller.text, passwordcontroller.text);
                  },
                  child: Text('login')),
              Text("or"),
              ElevatedButton(
                  onPressed: () async {
                    AuthenticationService service =
                        AuthenticationService(FirebaseAuth.instance);
                    await service
                        .signwithGoogle(); // Obtain shared preferences.
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => akun()));
                  },
                  child: Text('login with google')),
              const Text("Don't have account before ?"),
              const Text("Click Register below"),
              ElevatedButton(
                  onPressed: () async {
                    if (formGlobalKey.currentState!.validate()) {
                      formGlobalKey.currentState!.save();
                      // use the email provided here
                      AuthenticationService service =
                          AuthenticationService(FirebaseAuth.instance);
                      await service.signUp(
                          email: usernamecontroller.text,
                          password: passwordcontroller.text);
                      // Obtain shared preferences.
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => akun()));
                    }
                  },
                  child: Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 6;

  bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }
}
