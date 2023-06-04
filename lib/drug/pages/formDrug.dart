import 'package:flutter/material.dart';
import 'package:drug_reminder/drug/services/drug_service.dart';
import 'package:provider/provider.dart';

class FormDrug extends StatefulWidget {
  const FormDrug({Key? key}) : super(key: key);

  @override
  State<FormDrug> createState() => _FormDrugState();
}

class _FormDrugState extends State<FormDrug> {
  TextEditingController namaInputController = TextEditingController();
  TextEditingController hariInputController = TextEditingController();
  TextEditingController pilInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DrugService drugService = Provider.of<DrugService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF64FFDA),
        title: const Text('Tambah Obat'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Nama Obat",
            style: TextStyle(fontSize: 16),
          ),
          TextField(
            controller: namaInputController,
          ),
          SizedBox(
            height: 12,
          ),
          const Text(
            "jumlah pil",
            style: TextStyle(fontSize: 16),
          ),
          TextField(
            controller: pilInputController,
          ),
          SizedBox(
            height: 12,
          ),
          const Text(
            "hari",
            style: TextStyle(fontSize: 16),
          ),
          TextField(
            controller: hariInputController,
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(236, 28, 183, 222)),
                child: Text("Tambah "),
                onPressed: () {
                  if (namaInputController.text.isEmpty &&
                      pilInputController.text.isEmpty &&
                      hariInputController.text.isEmpty) {
                    return;
                  } else {
                    drugService.addDrug(
                      namaInputController.text,
                      hariInputController.text,
                      pilInputController.text,
                    );
                    Navigator.pop(context);
                  }
                },
              )
            ],
          )
        ]),
      ),
    );
  }
}
