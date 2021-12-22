import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add_data.dart';
import 'detail_data.dart';

class HomePage extends StatelessWidget {
  final String url = 'http://192.168.43.114/kampus/ApiMhs/getDataMhs';

  Future<List<dynamic>> getData() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API CRUD CodeIgneter'),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[700],
        child: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            // ignore: unrelated_type_equality_checks
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        _,
                        (MaterialPageRoute(
                            builder: (_) => DetailData(
                                  id: int.parse(snapshot.data![index]['id']),
                                  nama: snapshot.data![index]['nama'],
                                  jurusan: snapshot.data![index]['jurusan'],
                                  // list: snapshot.data!,
                                  // index: snapshot.data![index],
                                )))),
                    child: Card(
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
                              snapshot.data![index]['nama'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(snapshot.data![index]['jurusan'],
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('{$snapshot.error}'),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddData()),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add Data'),
      ),
    );
  }
}
