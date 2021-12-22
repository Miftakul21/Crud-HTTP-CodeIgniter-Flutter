import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit_page.dart';
import 'home_page.dart';

class DetailData extends StatefulWidget {
  DetailData(
      {Key? key, required this.nama, required this.jurusan, required this.id})
      : super(key: key);
  String nama, jurusan;
  int id;
  @override
  _DetailDataState createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
  Future deleteData(int id) async {
    var url = "http://192.168.43.114/kampus/ApiMhs/deleteDataMhs";
    http.delete(Uri.parse('${url}/$id'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Data'),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[700],
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.account_box,
                size: 50,
                color: Colors.black,
              ),
              title: Text(
                widget.nama,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.jurusan,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Apakah anda ingin menghapus'),
                              content: Text(widget.nama),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    deleteData(widget.id);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomePage()),
                                        (route) => false);
                                  },
                                  child: Text('Hapus',
                                      style: TextStyle(color: Colors.red)),
                                ),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => HomePage()),
                                            (route) => false),
                                    child: Text('Batal'))
                              ],
                            )),
                    icon: Icon(
                      Icons.delete,
                      size: 28,
                      color: Colors.red,
                    )),
                SizedBox(width: 8),
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditData(
                                id: widget.id,
                                nama: widget.nama,
                                jurusan: widget.jurusan))),
                    icon: Icon(
                      Icons.edit,
                      size: 28,
                      color: Colors.blue,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
