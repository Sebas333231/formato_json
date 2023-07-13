import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formato_json/pages/productoModel.dart';
import 'package:flutter/services.dart' as rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: const Text(
          'Formato Json',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text('${data.error}'));
          } else if (data.hasData) {
            var items = data.data as List<ProductoDataModel>;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                childAspectRatio: (0.6)
              ),
              itemCount: items == null? 0: items.length,
                itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 15.0,
                      spreadRadius: 3.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ]
                ),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                width: 200,
                                height: 190,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Image(
                                  image:
                                  NetworkImage(items[index].imagenURL.toString()),
                                  width: 210,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                          ),
                          Container(
                            width: 230,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 7,top: 15, right: 40),
                              child: Text(
                                items[index].nombre.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 1,top: 10, right: 40),
                              child: Text("COP "+items[index].precio.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: (){},
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFFA7FFEB),
                                      Color(0xFF64FFDA),
                                      Color(0xFF80DEEA)
                                    ]),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Detalles',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
              );
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<ProductoDataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('json_formato/formato.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => ProductoDataModel.fromJson(e)).toList();
  }
}
