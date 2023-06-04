import 'package:drug_reminder/akun.dart';
import 'package:drug_reminder/drug/services/drug_service.dart';
import 'package:drug_reminder/firebase_options.dart';
import 'package:drug_reminder/notif_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:drug_reminder/drug/pages/drug_detail.dart';
import 'package:drug_reminder/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:drug_reminder/drug/pages/formDrug.dart';
import 'package:drug_reminder/drug/pages/drug_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  await initializeNotif();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<DrugService>(create: (_) => DrugService()),
    ],
    child: const MaterialApp(
      home: MyApp(),
    ),
  ));
}

String text = '';
String text2 = '';
String text3 = '';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[300]),
      home: login(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    DrugService drugService = Provider.of<DrugService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF64FFDA),
        title: const Text('Drug reminder'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('id');
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => akun()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormDrug(),
                  ));
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: drugService.listDrug.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        width: double.infinity,
                        color: Color.fromARGB(255, 240, 240, 240),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DrugDetail(
                                                  detail: drugService
                                                      .listDrug[index],
                                                  index: index,
                                                ),
                                              ));
                                        },
                                        child: Image.asset(
                                          'images/amoxicillin.jpg',
                                          width: 60,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              drugService.listDrug[index]
                                                  ['nama'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'jumlah pil : ',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                Text(
                                                  drugService.listDrug[index]
                                                      ['pil'],
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      drugService.deleteDrug(index);
                                    },
                                    child: const Text(
                                      "Hapus",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
