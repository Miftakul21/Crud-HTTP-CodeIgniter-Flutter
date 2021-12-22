// ignore: unused_import
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController namaController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();

  Future<List<dynamic>?> addData() async {
    String url = 'http://192.168.43.114/kampus/ApiMhs/addDataMhs';
    // ignore: unused_local_variable
    var response = await http.post(Uri.parse(url),
        body: {'nama': namaController.text, 'jurusan': jurusanController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data Mahasiswa"),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    border: OutlineInputBorder(),
                    hintText: "Nama Lengkap",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey))),
                style: TextStyle(color: Colors.grey[800]),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextFormField(
                controller: jurusanController,
                decoration: InputDecoration(
                    labelText: "Jurusan",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    border: OutlineInputBorder(),
                    hintText: "Jurusan",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey))),
                style: TextStyle(color: Colors.grey[800]),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              height: 55,
              color: Colors.grey[700],
              child: ElevatedButton(
                onPressed: () {
                  addData();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  'Add Data',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
