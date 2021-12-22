import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial_android_flutter/page/home_page.dart';

class EditData extends StatefulWidget {
  EditData(
      {Key? key, required this.id, required this.nama, required this.jurusan})
      : super(key: key);

  int id;
  String nama, jurusan;
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController namaController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();

  String url = 'http://192.168.43.114/kampus/ApiMhs/updateDataMhs';
  Future updateData() async {
    var response = await http.post(Uri.parse(url), body: {
      'id': widget.id.toString(),
      'nama': namaController.text,
      'jurusan': jurusanController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Data Mahasiswa"),
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
                    hintText: widget.nama,
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
                    hintText: widget.jurusan,
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
                  updateData();
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
                  'Update Data',
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
