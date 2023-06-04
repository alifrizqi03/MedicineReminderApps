import 'package:flutter/material.dart';
import 'package:drug_reminder/drug/services/drug_service.dart';
import 'package:drug_reminder/login.dart';
import 'package:provider/provider.dart';
import 'package:drug_reminder/main.dart';

class DrugDetail extends StatefulWidget {
  final Map<String, dynamic> detail;
  final int index;

  const DrugDetail({Key? key, required this.detail, required this.index})
      : super(key: key);
  @override
  State<DrugDetail> createState() => _DrugDetailState();
}

class _DrugDetailState extends State<DrugDetail> {
  TextEditingController textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DrugService drugService = Provider.of<DrugService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF64FFDA),
        title: Text(widget.detail['nama']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
            textFieldController.text.isEmpty
                ? null
                : drugService.updateDrug(
                    widget.index, textFieldController.text);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            height: 600,
            color: Colors.grey[300],
            child: InkWell(
              onTap: () => {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    child: Image.asset(
                      'images/amoxicillin.jpg',
                      width: 150,
                      height: 200,
                    ),
                  ),
                  Text(
                    'detail obat : ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.detail['nama']),
                  Text(widget.detail['hari']),
                  Text('Jumlah Pil: '),
                  Text(widget.detail['pil']),
                  Text('masukkan jumlah pil : '),
                  ListTile(
                    title: TextFormField(controller: textFieldController),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendDataBack(BuildContext context) {
    Navigator.pop(context);
  }
}
