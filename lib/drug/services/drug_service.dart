import 'package:flutter/material.dart';

class DrugService extends ChangeNotifier {
  int? selectectedIndex;
  List<Map<String, dynamic>> listDrug = [
    {
      'nama': 'Amoksisilin',
      'hari': '  2 kali sehari',
      'img': 'images/amoxicillin.jpg',
      'pil': ''
    },
  ];

  void addDrug(String nama, String hari, String pil) {
    listDrug.add({
      'nama': nama,
      'hari': hari,
      'img': 'images/amoxicillin.jpg',
      'pil': pil
    });
    notifyListeners();
  }

  void deleteDrug(int index) {
    listDrug.removeAt(index);
    notifyListeners();
  }

  void updateDrug(int index, String jmlhpil) {
    listDrug[index]['pil'] = jmlhpil;
    notifyListeners();
  }
}
